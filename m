Return-Path: <cgroups+bounces-17625-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d2X4NHy8T2oWngIAu9opvQ
	(envelope-from <cgroups+bounces-17625-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:21:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F25D5732C78
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:21:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="TzAp/f7N";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17625-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17625-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FEF83008D3D
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F3F382379;
	Thu,  9 Jul 2026 14:51:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F0381E95
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 14:51:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608699; cv=none; b=VJkSwgFCnUKzE3mZc/gPZwpWKl9dWmzDjKpSnGTFkXfYL4r5o5wdb+4gwiGgeUOLO0ZV0oK3IXmkjPbjmpVkPriLZXY9cV1qM35zVk4J5O+HjbhwxxCtQKclgL/M3jsPrU0OB/khpwonFDg03E9XaCNa5wZYwz8VwO74XbCMO/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608699; c=relaxed/simple;
	bh=//lOxaht6je70+0qNvcjr8b5x27jQ+froO0+EuCVbKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trY1QCVmOTPkZKyAnJHHdmIOz2K8w/rGrSS8l/NRqOA1E3Kf6w9zkQvnToTz6et/RVLwBL0QRU1E6vnQYasgPMQ4iw20CndVmWTeDK/ODsd/rt4zH6lpLTMfz69qE0WxFZYaixd72kL2XCj3rcS6+r7nBAc6aAjCfHalmL0uOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzAp/f7N; arc=none smtp.client-ip=209.85.215.170
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8612812170so177869a12.2
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608697; x=1784213497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UT00T4Ch1e//1CySv92Ba/vSdArYfFyOvtjbEmuqjN4=;
        b=TzAp/f7NN/EkEvuJ9Likje7BK/CTS5geolbApgJ1dLIgfRE2KHxnfW16m7oYpCHm/s
         7hqp78UpfU5O3NiL6kxn1Yf1V+g8bcbma+SW6/HDABAPRvChRGYNCAgT6TxDMQ0BmTSb
         uDRNwA7C+2mM85V2E2ySl8pbpDDYls9aZBkI5CEdifrjIGTfFiLWl0ER5Wgqa/5dJn/S
         U3XLumBBv9x8mLFGl7MnvcCmc4cwZSQ35Zt8Lr93jA+Se8K4xG7Opf18fzDv2+mDbPqz
         FAtNOEDBg2NAw1ziIG+wEef69Uxm6h2lftH+SBthq8JKBjZQw3wEAhFfjyZxZdyPhNPl
         6bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608697; x=1784213497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UT00T4Ch1e//1CySv92Ba/vSdArYfFyOvtjbEmuqjN4=;
        b=lAq6ARv3KHQdNAvZUu+EPUD3b/ypwURztpn5KRcZrC2fsvzBGhZB8J5XJsL2oLB2+G
         tJZUR9Dj6ITSvOakvcnHzcSV3JzrzVy8qu82tT/MrmmPx3Yh2dtDVrswf6H5XMqinS9z
         1E5OPJ8CueFB7f6d+kdkTLh5W7gXqOZb2mf1BLBFAz2ceClgUtv9JWOtDRFqOnzVYyvU
         2tyMbwA7lQsYOpm+L2sUdr2kwVGZAAW0nPRYdIOaR52pvoYYQzdHeKKnAsakB17j+pPI
         un8xKWl0Zf5TlhfdDnM96mW7oRQ7x09KYkbtfacS8qPrwa5EQJXTDDdzztEY7KFzale3
         zq9Q==
X-Forwarded-Encrypted: i=1; AHgh+RrEJ8QC8CiL/ePIQh8ok+1JaKca4Ad33WsfWDC3cfNXdXV4BEKy0VwlJdhPhbc0KImOXxJOz7tK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5oCeQw4ISZLVBJY1IY6luUv3dqfU5SiAhY5wgxEvsew9MbdmU
	TjNv7vevy9IJXFfA+tq9/8Q4eaaRZIe3xYB0KGpuuEI+d9UKYezNvgrA
X-Gm-Gg: AfdE7cmrOppiWoy38rLYpa2PvlmC/SH+6wDHYLJbjUS3tdITSHUNQ7v+XulVzHZ+rtv
	4WGG77V0hwbn2BvxXlSTgBmIyaEWXQ5AKF756s2Aj7q/GoEMhiDc/QpP6uBpPgciM7zwNTdNP+P
	7Al5ixlRGgJ4/IvVhnRhewpvvjFo39N/eQ3J2HGGj0up3LmslEc/GC11jwuNqcIbOH9FFhd7XRi
	oD6kvArH4fzkkO9MeZZFlYQhEaJht5HhdVhby8eOi+XQf8kwAda0wMl7W5fA0F/bim6700iPakh
	VQX+bqJVZLdHvJSyJATeGV7gHQnhMJq5aZ5zPl73dh3M2piYa42eIrXBRDZfXvIIbI7TcOMP3ko
	g35vFSI1UF0fEqKxkduKujIb1GGPZVnQZbTuMV4tUUkw9uSZB0Bcza4HFcM98qQXuhUuxnFSY+q
	wOwp4Enfca35m+wshnn8G0KA93Qn2MRb7gHfbyTvm6+DaZcBXG1T5zcd0u7hK/N4XLHqXlLdHIN
	zWDhne7zVG25a9nqw==
X-Received: by 2002:a17:90b:5287:b0:381:2788:a437 with SMTP id 98e67ed59e1d1-38a1f1dbefamr3445540a91.1.1783608697342;
        Thu, 09 Jul 2026 07:51:37 -0700 (PDT)
Received: from debian.lan ([240e:391:ea3:6910:38e7:894b:82e3:a58b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a57dc5820sm1286917a91.10.2026.07.09.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:51:36 -0700 (PDT)
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
Subject: [RFC PATCH v2 0/3] mm: avoid large folio splits when swap is unavailable
Date: Thu,  9 Jul 2026 22:51:21 +0800
Message-ID: <20260709145124.764807-1-xueyuan.chen21@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17625-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:baohua@kernel.org,m:zhaonanzhe@xiaomi.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:youngjun.park@lge.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:xueyuan.chen21@gmail.com,m:xueyuanchen21@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,xiaomi.com,cmpxchg.org,linux.dev,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,infradead.org,google.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F25D5732C78

This is an RFC v2 of Barry's original RFC patch, "mm: Avoiding split
large folios if swap has no space":

https://lore.kernel.org/r/20260618221720.71768-1-baohua@kernel.org

Barry's RFC showed the no-swap case with MADV_PAGEOUT on 16KB mTHP: the
large-folio split counter increased by 1024 even though no swapout
progress was possible. Skipping the split in that case kept the counter
at 0.

This version keeps that behavior, but makes folio_alloc_swap() classify
the failure. The helper has both the swap allocation result and the memcg
swap charge result, so vmscan only needs to split when folio_alloc_swap()
reports that a smaller folio might still be swapped out.

Patch #1 adds page_counter_margin(), a small helper that computes the
minimum remaining chargeable space across a page_counter hierarchy.

Patch #2 uses that helper in the memcg swap path and lets
folio_alloc_swap() distinguish large-folio swap allocation failures:

  - -E2BIG: splitting may let smaller folios make progress
  - -ENOSPC: no global swap space is available
  - -ENOMEM: splitting is not expected to help, including memcg swap
    charge failures with no remaining swap capacity

Patch #3 makes vmscan split a large folio only when folio_alloc_swap()
returns -E2BIG. Other failures keep the existing activation path and avoid
destroying the large folio when no smaller part can be backed by swap
either.

RFC v1 -> RFC v2:
- Split the RFC into helper, swap allocation, and vmscan patches.
- Add page_counter_margin() and use it for hierarchical memcg swap
  capacity checks.
- Make folio_alloc_swap() return -E2BIG only when a smaller folio may
  still be swapped out.
- Return -ENOSPC for no global swap space and -ENOMEM when splitting is
  not expected to help, including memcg swap exhaustion.
- Make vmscan split large folios only on -E2BIG from folio_alloc_swap().

Barry Song (Xiaomi) (1):
  mm/vmscan: avoid pointless large folio splits without swap

Xueyuan Chen (2):
  mm: add page_counter_margin()
  mm: distinguish large folio swap allocation failures

 include/linux/page_counter.h |  1 +
 include/linux/swap.h         | 10 ++++++----
 mm/memcontrol.c              | 15 ++++++++++-----
 mm/page_counter.c            | 20 ++++++++++++++++++++
 mm/swapfile.c                | 21 +++++++++++++++------
 mm/vmscan.c                  |  7 +++++--
 6 files changed, 57 insertions(+), 17 deletions(-)

-- 
2.47.3

