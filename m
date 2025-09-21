Return-Path: <cgroups+bounces-10319-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42991B8DD31
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 17:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EF8189D119
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F411DF270;
	Sun, 21 Sep 2025 15:13:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C4282E1;
	Sun, 21 Sep 2025 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467629; cv=none; b=EeiLWC/NplGGH36XnONTRzvBj4GFR5jTOQfIxM5p3QOajdRAowxu0X0IybdgsEdrBe5N7H9cTwF/5nsXf6K8kLMkL9HKlmpelLWiT2MqSgHuX0rBw1wRqDz0CCGWuO8aD/TfsgxpyhWgM9OlHGmlZvPybCRQYsH+2vXE5zoEuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467629; c=relaxed/simple;
	bh=IIjIhfF2t8GgLMmXTTNs+U7K8mPPzaD6YpvseQhcB84=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=gr9bIa84eWQ35qjhEPpnpM71yF9qQrnAHdKsyGF7a8kAdXKbkExo21zHI1oWDpUET976cM7alPRwkf3F8rrSy6AjdNuUu5tZ9uCORPCwX9rG0wmTJTg6MkSTM2uivWgtnIVefygXqJQgctpS3Tmv2xGmQ8/qxCK6YIiawPnhP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cV8rt4Lqfz4xPS7;
	Sun, 21 Sep 2025 23:13:34 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 58LFDV0Z071842;
	Sun, 21 Sep 2025 23:13:31 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 21 Sep 2025 23:13:34 +0800 (CST)
Date: Sun, 21 Sep 2025 23:13:34 +0800 (CST)
X-Zmail-TransId: 2af968d0161e972-2a4e3
X-Mailer: Zmail v1.0
Message-ID: <20250921231334093OILrn169i655S8Pe0KMUC@zte.com.cn>
In-Reply-To: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>
References: 20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <xu.xin16@zte.com.cn>, <akpm@linux-foundation.org>
Cc: <shakeel.butt@linux.dev>, <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <david@redhat.com>,
        <chengming.zhou@linux.dev>, <muchun.song@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjMgNC82XSBrc206IG1ha2Uga3NtX3Byb2Nlc3NfcHJvZml0IGF2YWlsYWJsZSBvbsKgQ09ORklHX1BST0NGUz1u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58LFDV0Z071842
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sun, 21 Sep 2025 23:13:34 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68D0161E.001/4cV8rt4Lqfz4xPS7

From: xu xin <xu.xin16@zte.com.cn>

This remove the restriction CONFIG_PROCFS=y for the heler function
ksm_process_profit(), then we can use it for the later patches on
CONFIG_PROCFS=n.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202509142046.QatEaTQV-lkp@intel.com/
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/ksm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index e49f4b86ffb0..a68d4b37b503 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3282,7 +3282,6 @@ static void wait_while_offlining(void)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */

-#ifdef CONFIG_PROC_FS
 /*
  * The process is mergeable only if any VMA is currently
  * applicable to KSM.
@@ -3307,7 +3306,6 @@ long ksm_process_profit(struct mm_struct *mm)
 	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
 		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
 }
-#endif /* CONFIG_PROC_FS */

 #ifdef CONFIG_MEMCG
 struct memcg_ksm_stat {
-- 
2.25.1

