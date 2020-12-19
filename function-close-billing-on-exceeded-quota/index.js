exports.closeBillingOnExceededQuota = async ev => {
    const attributes = ev.attributes;
    const data = Buffer.from(ev.data, 'base64').toString();
    console.log(`Pub/Sub notification data: ${JSON.stringify(data)}`);
};
