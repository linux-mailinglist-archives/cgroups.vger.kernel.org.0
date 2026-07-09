Return-Path: <cgroups+bounces-17626-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uQJAKQi4T2oMnQIAu9opvQ
	(envelope-from <cgroups+bounces-17626-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:02:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B0A73297B
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:02:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="XQ/c2JrG";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17626-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17626-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF52A30C4F11
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBE838B7C3;
	Thu,  9 Jul 2026 14:51:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2537107F
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 14:51:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608709; cv=none; b=iwRcfXL/jQ4eSwSENlJkzXQi+7nXXRWZfHkgd03P7EW7ve2FnKPTwonyfk4Jqi45IRphNxpeuH5P1SEc2btzdc6gmOFQVhSlm9IzKv3Q7MYBFdWNQ7sesoY5oRWpXwIJeQaVdgb4ApwMLi3qakIiKI+iD1MOWAQ9YR8dYZutrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608709; c=relaxed/simple;
	bh=u8kyhcVVA79XOsTXqJeZWB7vTD/1+9t4Iys7W++lkss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCOnOEwl6J56IKFFhN1I3Kq6mD9o6lYIpn4c2lw5DtSsbWcW+Fu6u0EuW0n4z9XAn4cJfHJm69ls4ICJ9wgzEHPhO/l/U/uvxNQmUkUUVz49s6D+lgCGjq/P8ymCyHjE796u8WRTJw2p4OS0jFONLpbwMEIzMeGDVaWZRWgS6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ/c2JrG; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caa0551d8bso6753185ad.2
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608706; x=1784213506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HZxx8R8fiqL7iH7Cr5ccFQZpVZE6wUlCcBNvGW/3Kq4=;
        b=XQ/c2JrGi3sHEvVCXL9q7bieFBmQYvZtDVTGyqrtZuZbbm9O5X9YHWPmiNFeJ9k1G4
         htQI1/EepV7rW30WIeDu86vFP1jA9rinJ83WeoP9G/RPaPWrfaqq4RrOqavaUMtZxR0m
         SeaZf6iusz+5Qn1Hcvz1luDFV+pjt6dDGFzxXZgon9iBhRmXCrWSTJqa8HzBF7PZUb1L
         YpRjGKKxqhdVR+VRpRh9oWcr+FXgFOZ5a5euXd0KkfgqA7fXD8HQQvkFOqxJIPsqudiS
         m17LnCW05Vxe5RtVcPZ+xVSrjTEjj3RNMVpG3UgxVkEFJb7VCyqDkm5t294fzgfRQMY2
         V8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608706; x=1784213506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HZxx8R8fiqL7iH7Cr5ccFQZpVZE6wUlCcBNvGW/3Kq4=;
        b=tZW9KjZI+5mnRvLX0wGWrifg/wg1zl62vujYCkvCGJ4tXiW6O0Ksmo/DNzk4++F7bL
         wZqH5dU+SnCpLcHmY3k4jvaR44EymTB8P6q6Qw+gWNmp+2NrftxoMxTTvmg2gOp8Hgu9
         xmzNfWuWZkCkyEAPQOJ1YtVTV5/zrtDRZp4DDgLtuLLGZ+YYMiRX+zqnQhHxV0Lch0/q
         7y4ONL/jVWmU6MpiJOH6kHtCf/kTQOxGyA6evpWIFZ0chMww1vzHR0ahf4vZ6HoJkdKg
         x8SuUZN3pD7kCoshVDfcpRDVK8oqeUdDwqNpn9dMyhr2jfIS5+003SkfYj6wK4o0a1VP
         n+MQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrby0M1sbNy5k6zm2rIF1hUcljHawI83nLutcev8KZ5j5zWK81tFkl8oEkHSSQK32LwuqKUpcTI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0aewo2V0B7J5WzcbWjGeet3z5k31pGMUqWRYU3Z7oVq3s3rg
	Da7xrvSKLWAXLoQbkOtz9hGdRjq7UoZz7EI6cwJLILxeR0V9ghidHOdK9LtFxhPYb9gfvFFo
X-Gm-Gg: AfdE7clkt4c3MhpqAW0GtBskGeipI+veVVvUYvlaaPI/HZE+InFrMENgM+agG7Roery
	wNKFXGoNxHrgn8bCHZtCtIstDP+mW1JvglRmei6JK6iJolVyzREImLPygnGptJgmaNDwikKrm28
	IW3N74bV3IvSh/Tk9yaRXjwQUqDD3DlgFIdM11DYBbuTQmycj3nkrek5SCqgVPszSzBJ+IC9TvP
	z3cIkGJ5aTtLlVMlPXF+l8cX5ed/+gWGZ3aF1vXFOo91YDpMGtPvCSo39KMz3bVAilwzbdlGgCS
	29Guraa6pNwK1FMBwB0Yze+ZrietmHuiTbB8U26Vv46vDPebpAOGzsVLGyDlCIQ1jx1/mvdS3Ua
	5ztQ8kl18XGK6Io3RZl14zvyfMeZSZGfN7SQDfhHe2EAZinEJD3KJx70MGcyYOeldjnvIfdiNRU
	DUAVDr717ye5NkLLTy4bzvFBK9K5oDPdS0BywVq+5SZosKWPgBJW4Y7Gcf7CtHyxOOhk4jo2tHb
	nyml7TfubB0evDGdA==
X-Received: by 2002:a17:90b:58c6:b0:36d:b30b:14ed with SMTP id 98e67ed59e1d1-38a1f1de22amr3604367a91.2.1783608705954;
        Thu, 09 Jul 2026 07:51:45 -0700 (PDT)
Received: from debian.lan ([240e:391:ea3:6910:38e7:894b:82e3:a58b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a57dc5820sm1286917a91.10.2026.07.09.07.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:51:45 -0700 (PDT)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Youngjun Park <youngjun.park@lge.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [RFC PATCH v2 1/3] mm: add page_counter_margin()
Date: Thu,  9 Jul 2026 22:51:22 +0800
Message-ID: <20260709145124.764807-2-xueyuan.chen21@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709145124.764807-1-xueyuan.chen21@gmail.com>
References: <20260709145124.764807-1-xueyuan.chen21@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17626-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,xiaomi.com,cmpxchg.org,linux.dev,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,infradead.org,google.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:baohua@kernel.org,m:zhaonanzhe@xiaomi.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:youngjun.park@lge.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:xueyuan.chen21@gmail.com,m:xueyuanchen21@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[hannes.cmpxchg.org:query timed out];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60B0A73297B

Add a helper to report the minimum remaining chargeable space from a
page counter up to the root of its hierarchy.

This makes the hierarchical margin calculation reusable by callers that
need to know whether a smaller charge could still fit after a larger
charge failed.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
---
 include/linux/page_counter.h |  1 +
 mm/page_counter.c            | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index d649b6bbbc87..07b7cb12249c 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -68,6 +68,7 @@ static inline unsigned long page_counter_read(struct page_counter *counter)
 	return atomic_long_read(&counter->usage);
 }
 
+long page_counter_margin(struct page_counter *counter);
 void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_charge(struct page_counter *counter, unsigned long nr_pages);
 bool page_counter_try_charge(struct page_counter *counter,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 661e0f2a5127..6e55c7628025 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -171,6 +171,26 @@ bool page_counter_try_charge(struct page_counter *counter,
 	return false;
 }
 
+/**
+ * page_counter_margin - remaining chargeable pages within hierarchical limits
+ * @counter: counter
+ *
+ * Returns the smallest remaining margin between @counter and the root.
+ */
+long page_counter_margin(struct page_counter *counter)
+{
+	long margin = PAGE_COUNTER_MAX;
+
+	for (; counter; counter = counter->parent) {
+		long limit = READ_ONCE(counter->max);
+		long usage = page_counter_read(counter);
+
+		margin = min(margin, limit - usage);
+	}
+
+	return margin;
+}
+
 /**
  * page_counter_uncharge - hierarchically uncharge pages
  * @counter: counter
-- 
2.47.3


