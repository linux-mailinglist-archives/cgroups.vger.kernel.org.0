Return-Path: <cgroups+bounces-14139-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNr7Hv8dnGkZ/wMAu9opvQ
	(envelope-from <cgroups+bounces-14139-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 10:29:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A521173E97
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 861DB3005AA3
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A4934F24D;
	Mon, 23 Feb 2026 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WlNkxOLy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA141C84A2
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838970; cv=none; b=eKI9wmldKUqGnFkGTeTnPx3gvCLTnAN99yPeMivE+zXFC46AZ2CRjN8INPVPqwfmhQ1AkegFDXDd+mRRZhIVA8CGBQo3jK6YAx0aBS0I/esQZwAMXcsqOB7rX+J9QobhHKKbjBvI5L9aIKamkjjC/aiN/AmcroK6XsJz1ZZjoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838970; c=relaxed/simple;
	bh=0x53VE3n468/ZkLGoYLN4jzL8c12CefOfdcN6waYukk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roveSXig1PT9R9wWO1V5GSOyQAtykccB7JG2PlCZ19/sf/WTCNdPVaiIrLB81vowaGe7Viwln6vDu1iqRXd38GlQ6bMqDpproxIB0xj54vequRz2m3weDP9oYsDamPLAoJWN14aoniLy3ol+t8QGrBKGPc800KkVYpckh55nt2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WlNkxOLy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso34808545e9.3
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 01:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771838967; x=1772443767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qChLD4pBhJhKZJlnOIVXjltzDeGTKPjqI++HMTLBywg=;
        b=WlNkxOLyKnoz6JjtUZN3Dnfo0n3rTW5VohMB7eHSLnWV9A+YoWCYNTx/TjowbBoGli
         cq9M16bZVdcKq9yzHqi5tzSjlM/01FZQrD282c2So+HMGOqOfX5C58FEq/Juknghw98z
         +jTnCF9aG1R/Avn1wBQ95O4scvg4/8lVCvPPHn3cA+dgYQzqU/TO6H0bG0Y/9Tt/E6I7
         Hfc9Fq0lSsiea6zL6oxxmhRwR0PqZC/iR2LoyYkjSH2WqZZlzKa52nVoRyV3dXCSSQ9x
         59BzeYcUx5UQCdRhY+bIThT2UkjiLSZ7infpAJGsIG3GNrM6VraGM2ik2rhMeOOHWVWO
         k6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771838967; x=1772443767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qChLD4pBhJhKZJlnOIVXjltzDeGTKPjqI++HMTLBywg=;
        b=cfb91uSIpVQSEZimFgvhUYG+zdeoNgD7jiMMPk3lIyk2daTtZntO6AY2Aeznrsaun9
         92PLc2UYlvelZoKkUW6xGgQY3Fg1Ybi7fvRw/QcstMA3n1Nd0eTxLPo82BvSfmhROj6n
         hpeE7Pr68rRlQV63jfnYa+GJ5/Xoz3L41KyMueGgWwgUXb9vgq644xNA4E6azPrsm71w
         CQiWJac8jSfNRMAdn4JmTjfjMXJ64xYIU5qI2Av78BaWcYj+LlPeXXWQaY6B93DFMrFG
         Tjne8R8C5fxIPx9fupFBIicMGiO63DbFzkiyzB4KuRB4WC47C4KsuHgmV5Nqw0VTjPLb
         HiWg==
X-Forwarded-Encrypted: i=1; AJvYcCXy3QJmMcYdSkpOORWYjNeT1+chbcyJ1UBeDrGj7FJpglmq60D+uw4mPPt+kSvV2x+bPHqS8gQl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv/EtKjSRRzVpML1UY3VNF9ZCRvFfh5V1h8ymxyonSv9eHLwBx
	K9nvl5AKtXn3gT3dq34glrkSF68IkfmgvZdoWq6g/Ag6dg68cjZtFg7LCRyAybvj3jA=
X-Gm-Gg: AZuq6aI7LiTHDOC16c4IXcvGFN9i2vx6UCAX3tcjYzAbGhn2ufm++U7HT3m4pYE0RpH
	dsWeXJlbJ9vCIwXSnmwtKJErhPRYHq7N1fXoRR2bg2f/OUtLsnXdXgQxNWZC2OaIc2u+dPYInal
	61zBC9SGDkkKGqWo7s6rTJaDq2doHq83+jGFptHLNJrWf3u11shuFEw+vpR8sIeWub2CiPPIBE2
	4mpZHtcYPqXpOhwqeQiD0/2mCRc5NHInpGIgQ3fCMMKLR3qqJy4+ycCKdmTJJ36pJu314EatwJQ
	ZJ1QsqDGmqG4CGzCuiMDtgYtrGRe6MV7xY1EBFJdAaPB6cQONapOkrAipXSXVpuBKj8lBoEjWVa
	Fvv/KQlSmmbJ7BWAIkQMhpdIGrvaLRtez8XXS0onkwLw7SsETIDU9IDD49KP6oNS7Dtf1DqXaqG
	zI63rgfgd9dcVyWmBLNo1YMHf1s3sGARrEQ8dvXa+I1Ond
X-Received: by 2002:a05:600c:a49:b0:483:7631:befa with SMTP id 5b1f17b1804b1-483a95eb5e6mr149259535e9.5.1771838967038;
        Mon, 23 Feb 2026 01:29:27 -0800 (PST)
Received: from linux.fritz.box.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31f0370sm440197135e9.11.2026.02.23.01.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:29:26 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	cgroups@vger.kernel.org
Subject: [PATCH v2 2/2] block/blk-throttle: Add WQ_PERCPU to alloc_workqueue users
Date: Mon, 23 Feb 2026 10:29:20 +0100
Message-ID: <20260223092920.60424-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223092920.60424-1-marco.crivellari@suse.com>
References: <20260223092920.60424-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,kernel.dk,toxicpanda.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-14139-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,toxicpanda.com:email]
X-Rspamd-Queue-Id: 4A521173E97
X-Rspamd-Action: no action

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Cc: Josef Bacik <josef@toxicpanda.com>
Cc: cgroups@vger.kernel.org
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 97188a795848..cabf91f0d0dc 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1839,7 +1839,7 @@ void blk_throtl_exit(struct gendisk *disk)
 
 static int __init throtl_init(void)
 {
-	kthrotld_workqueue = alloc_workqueue("kthrotld", WQ_MEM_RECLAIM, 0);
+	kthrotld_workqueue = alloc_workqueue("kthrotld", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!kthrotld_workqueue)
 		panic("Failed to create kthrotld\n");
 
-- 
2.52.0


