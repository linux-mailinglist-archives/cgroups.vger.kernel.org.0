Return-Path: <cgroups+bounces-17229-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /vcmIFjQO2pxdggAu9opvQ
	(envelope-from <cgroups+bounces-17229-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 14:40:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DA26BE37C
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 14:40:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jVRfEuUJ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17229-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17229-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1BFA30BD2A7
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 12:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5FA214A9B;
	Wed, 24 Jun 2026 12:37:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5A26A0DD
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 12:37:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304621; cv=none; b=PktqsMdhHyRPbmwQDH0fgBea1q1luBUBiTAD5+oIrFehL1jPyKVRW2Jk8PPkwrbMp0pUiFOZvkFyWdi8nsLdH2wFJtC+VVB5KBYNce79j6lM3nGN5GTXCeLgmt3+ZwaOhtGh8bOAXCUJUgBgpiUJZIfP6Qdn7WF8SK9BKN/Tn8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304621; c=relaxed/simple;
	bh=n7yeLGokqqCEYqPAMP4LCZTg50ntP6woAwtrH9YhnIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdasYNka1Dfmg9WVwW+ZIGicQqv86mzadOOh/aKnhaPlOZMWcvcYY/DFmDDkq+RtTPwIeMNl1HE8Y1rW/91eo9sUPVn4IDmq14KoBuwKKaYlk9v+oAWLuQCcrFz7ly9R44tB8prbA+tGFvWnaN+bIFYGaJpVEvKYZ/TILDl96UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVRfEuUJ; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-492329c5514so4084435e9.1
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782304619; x=1782909419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aVVzYHaalnDwmrRDCXsQm1lcc3hZBz2mEnxrShCLD2c=;
        b=jVRfEuUJ1wAJ8mVKScQhvSR7fHYlYtfH7rwKA1RK1Co6ZDlmEosW7vQgATt7R0sgV7
         lPNO5UynbCc2RgSQx0Ii2V+fmj31w5E31k4MX37wEyIePdXUp7AumSFVyrH01XRIqTjf
         hVjpfdhFg6Olraa4rDeL6OAa27Exu/gSKcTiwz/xIfww+lthnQAxhOypazA6TA1Be/I8
         Sj1vRKqmk2A+m51NUNAh/f502DEiPfOxG5prwe92UawZN0a0OKw+j0y47KDwxPDBWIz5
         bEBuj8DsTmtQGZPFA8bgdWSVqKKetshqUtNFI2rs/j7JxT8MtDsqVJlIhaLe1miZEHwq
         wP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782304619; x=1782909419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVVzYHaalnDwmrRDCXsQm1lcc3hZBz2mEnxrShCLD2c=;
        b=rtkBXi6RuoDPdj+TqJefUxiVzZ23cGhPFSL1VSOBJc1clubC2z1Wv5trkAobRzWRSq
         1oMGfrPTFohtRC07biVxXKjF2JtRvBduqPmjaJ970azF/gzZss2bDd70CD6CC8A48yIe
         T3E59n9DtsutBSrSa+oVB+MPWnI0QJ7DKZkFu4xUCRB2dkOeRjqjZnj+tStFwF1G9iUk
         zwFVt5mx/I3KumA2oAaEQ4dZNUEB3qJbRBubWqThPJzec1DpDOwZHhNOfKSZChc+3Z8u
         YEUqpYSGLR2jKGz56Gv3wJS2dZpRS4YGErcZwmJ4Nur5Jn9hnXca8E2S0j4+ZHxUke/m
         CQ5Q==
X-Gm-Message-State: AOJu0Ywa4ZKZ87zxxnm3euuwAjGe2+Tsi8ycD7pD9RYdjya3BacXEceL
	f7Tkq0WZlGpbKRIZn+eiYD2BPoniWH03SISkw3GgGdWJD1FvlFBEKc7k
X-Gm-Gg: AfdE7ckSW6IhSD43LAZjiWnHNystWPuu9lRCCWB9owoWNXCZ6cox/+VQhWdlRJTpfeB
	ftFcJ19ZMaBGYIHvJeUahLNvkeEhaqSqzxaf9g1RAuJOVV81VuxWKIPoKRry0ZVqOljmMDXjeD9
	z/UhqWLYpleq6mSXgzihy3BzgKMtZSI0yC5nREhC/h7dF14aZleuaxS0UaSBLJT352wOJs15/Ve
	0hlc5JHwe6eoR+L1X9aZnOeq8LHQUTd4i0j2DNQv6xTqrgQtvxYXWoCzbeU6HtWaHWWrSNgpiJH
	FDzG7F5tsHJ9IYipL2Ww1Ozk8n6fvKytpPAFuOf1Nh4zmGgAc+NIWo38zTeTbK0MKh6WIc7EWt/
	WddSZymZcYHZbjDfo/NUluGs5W4PEZSHVC/2VWfNIwnNi1fMNEODjof4WnzJ7ECecXZAXUlhpFR
	u/c7uyGCUMha4W8/LVFVP4XGiORQ==
X-Received: by 2002:a05:600c:4747:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-492632b20b7mr4090775e9.13.1782304618712;
        Wed, 24 Jun 2026 05:36:58 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b359sm432036495e9.9.2026.06.24.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:36:58 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] tools/cgroup: iocost_monitor: parse help before importing drgn
Date: Wed, 24 Jun 2026 14:36:52 +0200
Message-ID: <20260624123652.8108-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17229-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alhouseenyousef@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iocost_monitor.py:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17DA26BE37C

iocost_monitor.py imports drgn before argparse can handle "-h" or report
argument errors. That makes basic usage help fail on systems where drgn is
not installed.

Parse arguments before importing drgn so the help and argument-error paths
work without the runtime debugging dependency. Normal execution still
imports drgn before reading kernel state.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 tools/cgroup/iocost_monitor.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index 933c750b3..bdd78ba27 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -15,11 +15,6 @@ import time
 import json
 import math
 
-import drgn
-from drgn import container_of
-from drgn.helpers.linux.list import list_for_each_entry,list_empty
-from drgn.helpers.linux.radixtree import radix_tree_for_each,radix_tree_lookup
-
 import argparse
 parser = argparse.ArgumentParser(description=desc,
                                  formatter_class=argparse.RawTextHelpFormatter)
@@ -34,6 +29,11 @@ parser.add_argument('--json', action='store_true',
                     help='Output in json')
 args = parser.parse_args()
 
+import drgn
+from drgn import container_of
+from drgn.helpers.linux.list import list_for_each_entry,list_empty
+from drgn.helpers.linux.radixtree import radix_tree_for_each,radix_tree_lookup
+
 def err(s):
     print(s, file=sys.stderr, flush=True)
     sys.exit(1)
-- 
2.54.0


