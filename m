Return-Path: <cgroups+bounces-16916-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ga6VE67fLWq3lwQAu9opvQ
	(envelope-from <cgroups+bounces-16916-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2026 00:54:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C5F67FF86
	for <lists+cgroups@lfdr.de>; Sun, 14 Jun 2026 00:54:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EPtYAaVb;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16916-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16916-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49389301CA75
	for <lists+cgroups@lfdr.de>; Sat, 13 Jun 2026 22:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C735200A;
	Sat, 13 Jun 2026 22:54:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F1131E49
	for <cgroups@vger.kernel.org>; Sat, 13 Jun 2026 22:54:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781391275; cv=none; b=HHkiiSRW5ZxOgPb8PVhKKCKp9k98ykKQc1U4nY8Ri0qkmIMYgsFm1oU1Fu/dy1yBUZKK/EtsPIKEjqiCNN4aY9AzEPIHJOtPg6lTUWbfBrhQ2gW38yT52tN9iaRrn8Ro/mClYtTZ4tElf9myzwijRBXNtXkUgaMB5qOJpy3t6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781391275; c=relaxed/simple;
	bh=iZbJHDSwm/+M/O7W6upSMl4Wv69MZ6HERedebOMSJkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpCNLEtWpO0lHg9aw3n06ZXRr0aJ11BmtZfhYnxRKUnyKSJYQjKUZ7Y1i2yJlfOBUO1SG4wEHmj2L10r8L60Kperj3j0VHbbnFnlWn46lHPRVG3Yd5OJQB1ND7iGdCRIeXwPoAveehzJgmCSXvqJMVcTXi0b55IKk+PX7IqYTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPtYAaVb; arc=none smtp.client-ip=74.125.82.194
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-304c520fe9aso4784930eec.0
        for <cgroups@vger.kernel.org>; Sat, 13 Jun 2026 15:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781391273; x=1781996073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aGN41lJJpUoPArkrSVIPW84Lj0UWsceBpbacK1PPJMQ=;
        b=EPtYAaVbdb7OMtts5QCZZjsrTny0h4X5jVsH+EtnJ13sSdXRfy3owCyVshZ5rVuCbf
         eg/O+6o2vWS2giZowymf6/LrUwEIXSdHpO39wQ0e9kaLZFWTvyGjqYOieJLc65HUDMoT
         ndRyVxX/hpXD+Ky9sEBNnsOKJxJOndx82F63GebSz+xqdEAcc6wb7ZTqAYsFAWSUbsfv
         iRuomQ0vkvwa7mRD0M7Bsky1riywd90nskZFDO0t3cDhdNQlQMu9u6oiyc+UjvvsyMKy
         vXFce/eQm1rdHk7sGgw5bnLv/fGGty8H3XT21zvIGrF26aQUtQ6fH6uC8g0XyN3EqYng
         aJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781391273; x=1781996073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGN41lJJpUoPArkrSVIPW84Lj0UWsceBpbacK1PPJMQ=;
        b=YZrXoQdoiKkZU+oDkG1nEHboiZmyuuLUvdzSiXAQ8a62Zxyyg/oNfSnX+aHZx5kOm6
         gWd0WdzOJBW0TrmmZxTmi9mg82IW+6EGgYL/4dSJ4t2zT6gPKQYQ9mgmsRW59dx+NR9k
         YIS0XhrjB/hMwJ+Aqi5DW8RmIlTI4ETgWDhe8A/5P0DrXwSVkBzAVcaTFRVpjqyVfMkw
         2KOvruvI1jDenR9fzQ/RsfmAljz1MgyZGyyHI5x3qY9IoDNyqL5ixrUKhQIKZwm53bUK
         JEjsySH1YVIiCqJpkHT3/VnRKhidiv4TTCJq/QQOxqXNqxk1KPeb9uibdX5jWfZ5Yc/b
         vMow==
X-Gm-Message-State: AOJu0YwouGdsnZbM10Nb5wVqq3CDvU0q9GpHDXF9ueld6AfZ23tmGUKb
	ytKgVhbNqexEELdQN16GE6BYXzsT/WR+l76OJD8Mfgw2oEnmatvLxQ1Qf9u7i9AZ
X-Gm-Gg: Acq92OE2Co/fGFx3BW/u5ZDkZzkba9pKrwfGIR23VCVc8LzZspxszfpaJQ63YzWBG9Y
	PnzHwnGnOpaXtBLETsrwvx/MDVVUrpgXQr53TmwNA/VsPXW0zwAJKfNqSBtlO1dW9aO9B+p+Dx+
	AcFwnTZ4jMkdMcrBQ8JV9v2cFXs/c/QoKjqf8yKsijQeQMUGbTNEwVamU8H9Bb2sveuPK3Zh601
	caT9yaYToptgVs0zhrYENlL/UB+M17ai1JOQaZbzKBnq/+LWocouee6spR3mVc090waG+akg8Bm
	xI7GPOJXqTqYQZQ/PyyV+FRVJY+XoTbc7KkDp4pQqPjDCnZerk+f1kjUyC9kqWlXndPTjp/aEU2
	4ONg8oOSppGsIulCjn+z/SkhRBovRCAEwdZvVwovSbcj6+QcoGDkaGDjguCqz4MVb+fViug0HOw
	XjQ+KOH9lqMsh7svMo8Eb1z/VhnvabD4GMs5v2UuBhHgKQ78Aft9d0AErwXgOPZC39L++qJ+XWP
	MJXXrjfhvKi9PynGRd5mWn7Y+X+u+Eu9d8CO5HX9SLjARXDvS/PWeHjbkV4EW+C1nUaBRg1QdnZ
	6UHazTxZKKrKO3oMtg==
X-Received: by 2002:a05:7300:4347:b0:304:2af3:5ffa with SMTP id 5a478bee46e88-3093ec3e363mr2952961eec.19.1781391273082;
        Sat, 13 Jun 2026 15:54:33 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43f69sm8413333eec.20.2026.06.13.15.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:54:32 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-iocost: correct CONFIG_TRACEPOINTS macro name in comments
Date: Sat, 13 Jun 2026 15:54:26 -0700
Message-ID: <20260613225427.139129-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,toxicpanda.com,kernel.dk];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16916-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:enelsonmoore@gmail.com,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enelsonmoore@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99C5F67FF86

Comments in block/blk-iocost.c incorrectly refer to
CONFIG_TRACE_POINTS instead of CONFIG_TRACEPOINTS. Correct them.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 block/blk-iocost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 0cca88a366dc..04630c36b737 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -205,9 +205,9 @@ static char trace_iocg_path[TRACE_IOCG_PATH_LEN];
 		}								\
 	} while (0)
 
-#else	/* CONFIG_TRACE_POINTS */
+#else	/* CONFIG_TRACEPOINTS */
 #define TRACE_IOCG_PATH(type, iocg, ...)	do { } while (0)
-#endif	/* CONFIG_TRACE_POINTS */
+#endif	/* CONFIG_TRACEPOINTS */
 
 enum {
 	MILLION			= 1000000,
-- 
2.43.0


