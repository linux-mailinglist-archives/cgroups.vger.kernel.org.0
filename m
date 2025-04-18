Return-Path: <cgroups+bounces-7641-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E017A93E6C
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 21:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2138E3DBC
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 19:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B222D4F0;
	Fri, 18 Apr 2025 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="F0Sfa4xw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282B15F330
	for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005823; cv=none; b=Bx2b7TQtAET0C3ku42auu1g+iQQdoWEmrnBFXeNGAILC/aVhG+rHiVCmvzDNpylnO6oAjiUd4IeElHyfsKA31eQwklIUQNWPywFcDfMRvfaODS4sa7H1hYhT/uVH6KJwEcLyII6twt7sWHRNtnVxCv88+V5B4UtVpvtyv8qv+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005823; c=relaxed/simple;
	bh=e9RelHQ6jACDHpYiEM2I/Tba3GRyqdVgZ/2MsbNgCaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD0VxaIFDQUI4vCOg+uanX0NIGXjR4gQy1TODIqqI2E24z9qTC9wrfTab2CcZ5v279a9Y2CNdo0zIZ6QU9VR9KpumYGFKG8mg3q59XNeIBe3/Jp3VfF6FKLrDN05pztrfb/B191/jTjfoqBGlzz3UW+2eTto3Ete9KAbbuNtWns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=F0Sfa4xw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so23321966d6.0
        for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745005819; x=1745610619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZIpJlMfSrAl5tIsrT+nGzfFnGMUyfcntMF+OWrMx0E=;
        b=F0Sfa4xwKNAzBe9SNHKHvFGMRE5Wo2drsXrpDF9q7hewAoooE5XAWn3cDWqs4hfGh9
         ppfhO07o56x4M+hHmtYC15U6Hc0GaQezZ088sg28bFyjH9PLaEchJ4Hkq9IPAFr00PZF
         POVGpoFTjUI/H+BgY0h2QNWEYjoMsNA72K//6kRzPmJiTcyjtyEAYa9REiGYDHm7jgOL
         GJxTWNQ4jOCT2g4v38OwbwMgVR8Jx9GmV/P8tLlmgdzEFgW/P2AiPkMckdDuYasNGblW
         lpPZa4D6jRx31GnMnfNcfZ5Q76dhKIzgsBPcR0qzevjivLqasM4bEkPiZDTlidT4nDNa
         lDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745005819; x=1745610619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZIpJlMfSrAl5tIsrT+nGzfFnGMUyfcntMF+OWrMx0E=;
        b=rP0VvPp3Z/37oxPPxt3RersyE0Fdv3dXNeUq18IIAjv6f22ZLomHW0atkXPS541WDn
         6V+ThjQsAO6CR+XXLdniLMee+JxIpwsDDt1x4BZWIrXs2VI/gZyDNNazU+f8IW3EGu4W
         Ju2E2rmDcMSuQxctyLyTm/7jvD0+sCc/e0XTN0oPGQ6oQeASLobtrEZWFOBxMJxo58K8
         O2JHie5tE1YGIh2J+0AN+xwC1Vzz4/7uQn5kLz1UkxMEJsAchF81wthc/tdkgCe1Atmd
         j0DefcPLjjIWyWe9QcYUhEgNF0x5lmEAIwTg5ZXgBpU+b1Joml7Desl7qECoYkn9VEQ0
         1hgw==
X-Forwarded-Encrypted: i=1; AJvYcCWUPrrjgpxeRJe/65dAUkgbJissmP5WHLiF4vwqNoHk74H79z5ITMCCc81a/Olh6dQwnecKzoUu@vger.kernel.org
X-Gm-Message-State: AOJu0YzNN9q7zYsvbW+D543qK4xoEl/H0LHMP2STKriO7G8ba5SzEq0I
	lIIpksY33GtoA4LUsq5rT1RgO/YrWVPu0l6hiZ/NW23/RXDgpSsLhSJtKUPd+gU=
X-Gm-Gg: ASbGncvmtafPoqaJvP7CGQKJyQ9TgOtuMf+CUhkmGTYbkVk45JOzOCRi63tjMtEpQ6u
	B2RL0zyTk+tK/72WXcEGmgiCP0BuEiKmEur+fbxunB81rXz/qK6/N7hGGb82/k0sa6izr3jOMvU
	/5hMPl1OfSIIs4xpolUtd0vo0V7JRtnM2EFJCLvy5vbRCbBXL/qLGPp9jsTHFobzXb6ex3sc7g5
	Rif3XjWkyhHPA/H1R2X3sBWK9ZUUwQiXBsuhLuYjViqgy+1lEjpGsar/Vg3wnlKxkHr+mgjkjdh
	9warpJRqyxnIkEF70tvFIqhemvFhZUFr7ii+pdk=
X-Google-Smtp-Source: AGHT+IFG3LBqPjgQwSPk23I9MqvaEayWbINNH1Mnqd7uxhMrvknN6OBJKn7Qk/jpVgEALxeT6uR8iA==
X-Received: by 2002:ad4:5ba7:0:b0:6e8:98a1:3694 with SMTP id 6a1803df08f44-6f2c44eb12fmr73235786d6.8.1745005818730;
        Fri, 18 Apr 2025 12:50:18 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f2c2c21d90sm13760766d6.105.2025.04.18.12.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 12:50:17 -0700 (PDT)
Date: Fri, 18 Apr 2025 15:50:13 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	david@fromorbit.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com
Subject: Re: [PATCH RFC 06/28] mm: thp: introduce folio_split_queue_lock and
 its variants
Message-ID: <20250418195013.GA877644@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-7-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-7-songmuchun@bytedance.com>

On Tue, Apr 15, 2025 at 10:45:10AM +0800, Muchun Song wrote:
> @@ -4202,7 +4248,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		if (!--sc->nr_to_scan)
>  			break;
>  	}
> -	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> +	split_queue_unlock_irqrestore(ds_queue, flags);
>  
>  	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
>  		bool did_split = false;
> @@ -4251,7 +4297,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	list_splice_tail(&list, &ds_queue->split_queue);
>  	ds_queue->split_queue_len -= removed;
> -	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> +	split_queue_unlock_irqrestore(ds_queue, flags);

These just tripped up in my testing. You use the new helpers for
unlock, but not for the lock path. That's fine in this patch, but when
"mm: thp: prepare for reparenting LRU pages for split queue lock" adds
the rcu locking to the helpers, it results in missing rcu read locks:

[  108.814880]
[  108.816378] =====================================
[  108.821069] WARNING: bad unlock balance detected!
[  108.825762] 6.15.0-rc2-00028-g570c8034f057 #192 Not tainted
[  108.831323] -------------------------------------
[  108.836016] cc1/2031 is trying to release lock (rcu_read_lock) at:
[  108.842181] [<ffffffff815f9d05>] deferred_split_scan+0x235/0x4b0
[  108.848179] but there are no more locks to release!
[  108.853046]
[  108.853046] other info that might help us debug this:
[  108.859553] 2 locks held by cc1/2031:
[  108.863211]  #0: ffff88801ddbbd88 (vm_lock){....}-{0:0}, at: do_user_addr_fault+0x19c/0x6b0
[  108.871544]  #1: ffffffff83042400 (fs_reclaim){....}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x337/0xf20
[  108.881511]
[  108.881511] stack backtrace:
[  108.885862] CPU: 4 UID: 0 PID: 2031 Comm: cc1 Not tainted 6.15.0-rc2-00028-g570c8034f057 #192 PREEMPT(voluntary)
[  108.885865] Hardware name: Micro-Star International Co., Ltd. MS-7B98/Z390-A PRO (MS-7B98), BIOS 1.80 12/25/2019
[  108.885866] Call Trace:
[  108.885867]  <TASK>
[  108.885868]  dump_stack_lvl+0x57/0x80
[  108.885871]  ? deferred_split_scan+0x235/0x4b0
[  108.885874]  print_unlock_imbalance_bug.part.0+0xfb/0x110
[  108.885877]  ? deferred_split_scan+0x235/0x4b0
[  108.885878]  lock_release+0x258/0x3e0
[  108.885880]  ? deferred_split_scan+0x85/0x4b0
[  108.885881]  deferred_split_scan+0x23a/0x4b0
[  108.885885]  ? find_held_lock+0x32/0x80
[  108.885886]  ? local_clock_noinstr+0x9/0xd0
[  108.885887]  ? lock_release+0x17e/0x3e0
[  108.885889]  do_shrink_slab+0x155/0x480
[  108.885891]  shrink_slab+0x33c/0x480
[  108.885892]  ? shrink_slab+0x1c1/0x480
[  108.885893]  shrink_node+0x324/0x840
[  108.885895]  do_try_to_free_pages+0xdf/0x550
[  108.885897]  try_to_free_pages+0xeb/0x260
[  108.885899]  __alloc_pages_slowpath.constprop.0+0x35c/0xf20
[  108.885901]  __alloc_frozen_pages_noprof+0x339/0x360
[  108.885903]  __folio_alloc_noprof+0x10/0x90
[  108.885904]  __handle_mm_fault+0xca5/0x1930
[  108.885906]  handle_mm_fault+0xb6/0x310
[  108.885908]  do_user_addr_fault+0x21e/0x6b0
[  108.885910]  exc_page_fault+0x62/0x1d0
[  108.885911]  asm_exc_page_fault+0x22/0x30
[  108.885912] RIP: 0033:0xf64890
[  108.885914] Code: 4e 64 31 d2 b9 01 00 00 00 31 f6 4c 89 45 98 e8 66 b3 88 ff 4c 8b 45 98 bf 28 00 00 00 b9 08 00 00 00 49 8b 70 18 48 8b 56 58 <48> 89 10 48 8b 13 48 89 46 58 c7 46 60 00 00 00 00 e9 62 01 00 00
[  108.885915] RSP: 002b:00007ffcf3c7d920 EFLAGS: 00010206
[  108.885916] RAX: 00007f7bf07c5000 RBX: 00007ffcf3c7d9a0 RCX: 0000000000000008
[  108.885917] RDX: 00007f7bf06aa000 RSI: 00007f7bf09dd400 RDI: 0000000000000028
[  108.885917] RBP: 00007ffcf3c7d990 R08: 00007f7bf080c540 R09: 0000000000000007
[  108.885918] R10: 000000000000009a R11: 000000003e969900 R12: 00007f7bf07bbe70
[  108.885918] R13: 0000000000000000 R14: 00007f7bf07bbec0 R15: 00007ffcf3c7d930
[  108.885920]  </TASK>

