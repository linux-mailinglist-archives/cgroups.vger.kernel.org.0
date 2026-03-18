Return-Path: <cgroups+bounces-14905-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK0qIV8xu2kEggIAu9opvQ
	(envelope-from <cgroups+bounces-14905-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 00:12:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A82C3BF2
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 00:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E5DF3043FBE
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960ED33F5BE;
	Wed, 18 Mar 2026 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7+3YBp8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D65314A8E
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773875548; cv=pass; b=EL9ey8IGzepwNaSKx63P7sE5i8p0QNVOUiO0qecZg26PxT4kM91SPfyQu+2FeCANzTRzMCOlJthgognXfRxl1ZCMbM9WhsRSBp9905SHKQz2QO9YrVyyT3yL2R0Gdryz08peXiGOVG7xipTV5Yahaxa2Glt4QrWxslWr5BGBa/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773875548; c=relaxed/simple;
	bh=uJGBe8XFPVCDFc8zym9ewMOeq6lHfcpqgZp834IlRt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgOS3b/CXBH2ZpwFjzsVw6hfmwx9yoJC1vsZqSkbwyzZC2XsIlr8EE/DBvXz/Q0I9Dn4VPb32MN9dUpoM7X4PI7whvcNqe76koaLn1zKVW0wDBgI2Fo5WCGtzUzwaFHTUAG/4eVbLBR6+XELbSRWWkzvbYDo+OER4s/WxY/hwCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7+3YBp8; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38a76ba6a78so338701fa.0
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 16:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773875545; cv=none;
        d=google.com; s=arc-20240605;
        b=IZx6K48GJD3bcqCW+GpcRBe5vkjb3d8Jdeh7ML3LaG0veLnVS8qBIVppXVrcCMURA5
         iJ0pDYlRvRmdGyWDBlHDPR2+IgOih8ShbNGDZ117pOdnR0gf35jAaadhUIaLRt+U1paq
         J01qu58xc40UHr4q2PvaGH5SYuHQw8jDxAiuaYTBewWEQts4eOZnzjnat+02OqyX0Te7
         M2sXTKJDa8qjoEqwMetCOu4VikCXIGKzMQqbOd3ITmBbcmsO730IuEX5tneToP1o4Vah
         eEvn+K5gvwXBQY5hFPYI2YsKyZfIe6H8ujqj4z1IrlDokxeqHjRob09Mz46IyyRwHtqQ
         6+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BX2iHwtPTib43JUHo2OtCHlhT2FiqspzClwmirSToVw=;
        fh=rtxJR9jqAXX2ZzZqGKy6k+1rjyMxYldWd4RM7WSBuL8=;
        b=C8d1gDSuSfx/THmurf+wszxejo0cWM8AnWsnVpOJRLEEx3+EKfDbThroNK1u+z0glj
         PfBXJiUn9oBkznMmrpzSVieJMiGa9lBIHEJxy1wFkJcd79ANuM8AkgyzqnfbSkk737HK
         ToQmg4ESwT8Rreu003YMo6xxqCD7Ip4efJcwz3Vs4iiXgv6nLspA9370AL1603qJFqly
         ZZgpwS92JRLCxkerojOMlwk4YRq7enfS+FeQu5ovLZGcbgSAcnYYIf5M+1zpmZT+1z7s
         SY1mdqnbHtMAleH2aOv0Nhh/cxGenNGCQXiiUGgW6JAtV7t3djh3caJOxyb8TUupwF69
         OEKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773875545; x=1774480345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX2iHwtPTib43JUHo2OtCHlhT2FiqspzClwmirSToVw=;
        b=V7+3YBp8TX2aqyyNe/E1Hlo6TXeX/jWGsX0ru20MHaicEENXYZXR3JEKcCaIjkoW4L
         shvnYtnd02oOqgmrGXd31L2CQQiKkV2n/esnR8pVunk1KiO2g/oOQ9Oab1VmU891DbpF
         yS+JJsFa5lUZumcmtR6kuntwJtXeE3ZXatURJMThCcpV09Wodbk1FdqYTx+HamX9Ns8k
         1wrRW9G1sqzwNDGhcnF0wFuuiHqYgxu6ZuZN1dXmhI5YaSy4RQ2147FbsH5iuX66QGqp
         p60dtRkrIc48UmxJHUM+JVTa9V48Ac7rPTlAlwYZj7uxaj3/KnucXjCeiBvoeSYFytcp
         V7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773875545; x=1774480345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BX2iHwtPTib43JUHo2OtCHlhT2FiqspzClwmirSToVw=;
        b=qL3q+sabqQD3PZHKzNDMO704qtvpbW4np6GxTP82tkcC4wVBbG0OzeTXDzTERfwyxO
         6ofD2SPEMnXysHncFAiOu7qaZzywzQnXHm64KYitHhq1N7a0dV0FBChr1N4BQTKAZBUh
         Qx2ew5V1KzPPHru+jQhVK7u6qVknj3NrNyNrw6TtD6UXzHxjM6wMXhhLnwjEtIQ/m/iL
         YIkWy6rjAlBXuSLznzFdnEBPV8yJQuGUwHJ8X4gXrdWnHEN7TspEcPltZzGcnUnbjhRf
         vpTwP78KgztCXM2DNP3X6x1lmbj72Ab6NjWiMxMGTKvT9wavj0R6dML3YYSMZVQpCpov
         Yg0A==
X-Forwarded-Encrypted: i=1; AJvYcCVMJ0AqU4BxGUx9bUu3ajkiLpph5nuagP6ZVm3N+m9rV0nzsHjgpjHVfAuRK2owd8pk8ATvYjQP@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTAFlYr0iwEFx1Ev0IsgVN2NJeTuKsqzSwujwZj7zhG2odfcQ
	IHtm/gQB/n4lm6v9NI1mfGBIsBPNUdTASm002J1sNx7JQ7Y/hR8WqUYdE/yF3ZASFw1tq1v38Hq
	R+dJaHz2LjzIp5JKIStikfFT3Y5IO/Io=
X-Gm-Gg: ATEYQzzkUayKeDBn2WZjC9/V9PEsgqyZjc157in7m4/7ZkFKc4pbR7UkasT/urmLb+V
	SRPca6u7AmOx7SRvy+NLSJjCjn3otQo6dr5gfsVGHh788RH5vCGThY0u2UG1lJ9j56LrClQBVk9
	ySeiOKOCHiKA4oKLlk+pG4vE4IujrAPfu1Dx6Qh+C6CE0dnfyCxnHQ8iUHH4jctA5L3Kn6+fXji
	gMep99mLdNevuj1/LKYNgGzIfgYrZILZXdHFJo8LZ+WBMRCTOaalhOIXm4evifsdVHNitw+t/2M
	Ds3biNgIv8rIHFbXIuridNciLY1HIMEOCNlv1rWY68dfu7MQfINCSbsub0clZ+CD7A==
X-Received: by 2002:a2e:9bd8:0:b0:38a:4de2:85d7 with SMTP id
 38308e7fff4ca-38bd57813f6mr16258931fa.3.1773875544905; Wed, 18 Mar 2026
 16:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318222953.441758-1-nphamcs@gmail.com>
In-Reply-To: <20260318222953.441758-1-nphamcs@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 18 Mar 2026 16:12:13 -0700
X-Gm-Features: AaiRm52Vh6KL3hLud6f_VY3t_swyNqO1ijXNToeNb-CGlcr3QBKt9nfVJNa08qE
Message-ID: <CAKEwX=MV9axc+2V2y65hZ6s2tHc4_mU_aJ-94FQpmU3XZ9AnFA@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] Virtual Swap Space
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TAGGED_FROM(0.00)[bounces-14905-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.472];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E56A82C3BF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 3:29=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>

[...]

Argh I copied my draft cover letter over the diffstat. My apologies -
here's the rest of the cover letter. Base commit is
05f7e89ab9731565d8a62e3b5d1ec206485eeb0b for your convenience (it's at
the bottom too - this should be 6.19).

Nhat Pham (21):
  mm/swap: decouple swap cache from physical swap infrastructure
  swap: rearrange the swap header file
  mm: swap: add an abstract API for locking out swapoff
  zswap: add new helpers for zswap entry operations
  mm/swap: add a new function to check if a swap entry is in swap
    cached.
  mm: swap: add a separate type for physical swap slots
  mm: create scaffolds for the new virtual swap implementation
  zswap: prepare zswap for swap virtualization
  mm: swap: allocate a virtual swap slot for each swapped out page
  swap: move swap cache to virtual swap descriptor
  zswap: move zswap entry management to the virtual swap descriptor
  swap: implement the swap_cgroup API using virtual swap
  swap: manage swap entry lifecycle at the virtual swap layer
  mm: swap: decouple virtual swap slot from backing store
  zswap: do not start zswap shrinker if there is no physical swap slots
  swap: do not unnecesarily pin readahead swap entries
  swapfile: remove zeromap bitmap
  memcg: swap: only charge physical swap slots
  swap: simplify swapoff using virtual swap
  swapfile: replace the swap map with bitmaps
  vswap: batch contiguous vswap free calls

 Documentation/mm/swap-table.rst |   69 --
 MAINTAINERS                     |    3 +-
 include/linux/cpuhotplug.h      |    1 +
 include/linux/memcontrol.h      |    6 +
 include/linux/mm_types.h        |   16 +
 include/linux/shmem_fs.h        |    7 +-
 include/linux/swap.h            |  185 ++-
 include/linux/swap_cgroup.h     |   13 -
 include/linux/swapops.h         |   25 +
 include/linux/zswap.h           |   17 +-
 kernel/power/swap.c             |    6 +-
 mm/Makefile                     |    5 +-
 mm/filemap.c                    |   14 +-
 mm/huge_memory.c                |   11 +-
 mm/internal.h                   |   24 +-
 mm/madvise.c                    |    2 +-
 mm/memcontrol-v1.c              |    6 +
 mm/memcontrol.c                 |  144 ++-
 mm/memory.c                     |  109 +-
 mm/migrate.c                    |   13 +-
 mm/mincore.c                    |   15 +-
 mm/page_io.c                    |   83 +-
 mm/shmem.c                      |  227 +---
 mm/swap.h                       |  179 +--
 mm/swap_cgroup.c                |  172 ---
 mm/swap_state.c                 |  306 +----
 mm/swap_table.h                 |   78 +-
 mm/swapfile.c                   | 1517 ++++-------------------
 mm/userfaultfd.c                |   18 +-
 mm/vmscan.c                     |   28 +-
 mm/vswap.c                      | 2008 +++++++++++++++++++++++++++++++
 mm/zswap.c                      |  142 +--
 32 files changed, 2942 insertions(+), 2507 deletions(-)
 delete mode 100644 Documentation/mm/swap-table.rst
 delete mode 100644 mm/swap_cgroup.c
 create mode 100644 mm/vswap.c


base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b

--
2.52.0

