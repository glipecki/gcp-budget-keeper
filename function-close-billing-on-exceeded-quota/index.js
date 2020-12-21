const TelegramBot = require('node-telegram-bot-api');

const config = JSON.parse(process.env.CONFIG_JSON);

exports.closeBillingOnExceededQuota = async ev => {
    const data = Buffer.from(ev.data, 'base64').toString();
    const {
        billingAccountId,
        budgetId
    } = ev.attributes;
    const {
        budgetDisplayName, // "My Personal Budget - The human-readable name assigned to the budget.
        alertThresholdExceeded, // 1.0
        costAmount, // 140.321 - The amount of costs accrued. The type of costs tracked depends on budget filters & settings.
        costIntervalStart, // "2018-02-01T08:00:00Z" - The start of the budget alert period. Cost reported includes costs for usage starting at this time. Currently, this is the first day of the month during which the budget usage occurred.
        budgetAmount, // 152.557 - The amount allocated in the budget.
        budgetAmountType, // "SPECIFIED_AMOUNT" - The budget amount type. This can be either "SPECIFIED_AMOUNT" (a fixed amount) or "LAST_MONTH_COST" (last month's costs).
        currencyCode // "USD" - The budget alert currency. All costs and budget alert amounts are in this currency.
    } = data;
    console.log(`Pub/Sub notification data: ${JSON.stringify(data)}`);
    if (config.notifications && alertThresholdExceeded >= config.thresholds.notify || 0.5) {
        await onNotifyThresholdExceeded(budgetDisplayName, alertThresholdExceeded, costAmount, budgetAmount);
    }
    if (config.cutOff && alertThresholdExceeded >= config.thresholds.cutOff || 0.8) {
        await onCutOffThresholdExceeded(billingAccountId, budgetDisplayName, alertThresholdExceeded, costAmount, budgetAmount);
    }
};

async function onNotifyThresholdExceeded(budgetDisplayName, alertThresholdExceeded, costAmount, budgetAmount) {
    console.log(`Notify threshold exceeded [budgetDisplayName=${budgetDisplayName}, alertThresholdExceeded=${alertThresholdExceeded}, costAmount=${costAmount}, budgetAmount=${budgetAmount}]`);
    if (config.notifications) {
        await Promise.all(config.notifications.map(async notification => {
            const message = `Budget ${budgetDisplayName} exceeded ${alertThresholdExceeded * 100}% of budget (${costAmount}/${budgetAmount})`;
            if (notification.type === 'telegram') {
                console.log(`Sending notification via ${notification.type} [chatId=${notification.chatId}]: ${message}`);
                await new TelegramBot(notification.botToken)
                    .sendMessage(
                        notification.chatId,
                        message
                    );
            }
        }));
    }
}

async function onCutOffThresholdExceeded(billingAccountId, budgetDisplayName, alertThresholdExceeded, costAmount, budgetAmount) {
    console.log(`Cut off threshold exceeded [budgetDisplayName=${budgetDisplayName}, alertThresholdExceeded=${alertThresholdExceeded}, costAmount=${costAmount}, budgetAmount=${budgetAmount}]`);
}
