Return-Path: <cgroups+bounces-14232-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLOGIj4EnmlaTAQAu9opvQ
	(envelope-from <cgroups+bounces-14232-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 21:04:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A775E18C43C
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 21:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B3F230610E3
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15652DB7BF;
	Tue, 24 Feb 2026 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="AUM2zdyw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7472333729
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963451; cv=none; b=mbROwseRF8V9j1cn3lKosZbBAzzfQvBNbY3GvpGemcmYelJ1BTlWDMeF+XvnFeaOzCOFUydPm+dpA//XAQWb74CJaKP+N4Wf6EnUFTGSB/P0tGCpK5IluBr2p3poAbdFWe8zbVTbIYtldoqIIx9vS/d+Bb6wbcwHaemKC6HXkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963451; c=relaxed/simple;
	bh=EY3X/GbQP1UHkBYA2aCjxbCF6E3NLDDOtQj5TdI+ycg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS90zeDaL/6ehltMZFFMQ8IUQyIx2YKCNgo9/5S6hEtksc/w14lK+kwHp9kjOuVasP0O0kiAtU10ZvB7t0w2YodmepBHvNqFYl2d1lFDCoUGrhZvlCX99NwVuVLMbZ1i5JfVPBsrwYf6sth93O4BRSz6kbLScgEgL9c0zM9rpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=AUM2zdyw; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-899a9f445cbso12204986d6.0
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 12:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1771963447; x=1772568247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kez7XbtF2ZH1d8xoXH+eVokCW4VeclXLsEwDWocfZR8=;
        b=AUM2zdywz/Sf+8c1mr3ei/TqXanB0wVi6mkHQblhwEr0HgFsTGSe5S2VF/yM5aFMR/
         7qn2x1SXuGo8SBpVpVH8SmUDaTZieVVW0xDVcfVXMv4OqAq623URjY18Qf745nKAfUEz
         jquTridFN2m/zaTde7C6mk8oswnRGobtrBDb8xwfr7tLzDOZTM40TpFfs6lsn9PYV95l
         jYBSj64vRhZ9yF5VBmD1k5aUu6nr46EDAh9ao/iDLRtCiFpsWxM6yL44MKWBTMGfRZxk
         5O+i18fuDSitWV5uxl2/1tkcStc72W2kWfsunbDAGpxL6Dx7l+aKwXgum49rzmO5Cmmm
         aHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771963447; x=1772568247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kez7XbtF2ZH1d8xoXH+eVokCW4VeclXLsEwDWocfZR8=;
        b=hcGVNKlfK992/BDeV9bkSL/iKRLVi/EUW0/29ZB9WkrKwiWgh6/LdFCm+eb9gix27y
         knFNlc7ysjEx5PRN+3ohWvfxAvC1c12TdZjmfl+H2Uoq5RMB5sLkxBBB3jimtGPjPneU
         M3j9xOn4ZqJT6YzxHRNjrAY82dBegyHoVAIuYX3VEKsGvP+uHdqkYDasFG9/litto/Tj
         dI5kkRdZbTQ4h66PYyfHniQcgvFRe2rg65NNpCs5UA7OGGyCSDbRfBrRhd/4WESBtHQN
         OKkgX/OzMMc6F2c1l1qkrzmFZfSZCz28G1CWAUmJaL7UQOn7OuGj8G9jSaytWIVNxSR+
         TN+g==
X-Forwarded-Encrypted: i=1; AJvYcCWpEPNA8OUYEwHGBH7ZBb/F6No0dPkWD1cp6MMTZNfi8EhMxLtWCdqxFvCzXHhpkZK0hW8f0nRx@vger.kernel.org
X-Gm-Message-State: AOJu0YwGeZnmHfsHywdVxRg8+yB1HjUM9BOFzOq8MERT9YIUEZxjutEW
	9ma19w81JAq+mue+LB1Y/mdGjHP26hRBrR1zjBUc/yL22ec2YkZzqulKuMxP2ZeF7gJXdO3jF39
	02fik8BG3YwEPeTXKWE9+vwoEuZZA/CP9zzgtadAtL3HtXi8MxG7Zu3cUfUJh3xjEB1Eq1qbtSo
	O2ZiFV+izWDRe84AonUGHmRwQw4YgJxGh5pNiGKg==
X-Gm-Gg: ATEYQzyMaBVa9+UVtz2FGGKghP66Qn3DtKNhPdfC7Mxtkqk3ikCFh4JrYdFRr6J0SW0
	L0YF8nkOHKdsy8my/9KNG9wGCmG/mmRTGPh/j1thhQgxJSGsXyBWDzsX1BuozcFl9LcrsktUNSg
	mX/J0ncbg497u/xrHzILgNaiaNfagxClzauwn4TKXNS+1qK/NOq9XrEhQ5/4P6j85p2U5D3bRO2
	xs6oMcTsOSnGg/p8SJ4HhRwCWi9i1sNUWUiaj5iRfr067F+DD10sywBZ1rq3jEsGunW0p5NGTOz
	JoHAGZu3D2NoR7wpggLN61+mtj12qj4KqWbg0cKHTciNSl/rS48zVOHlsQIB4cVpFLIzym+C7fs
	S8wz8WCQMRMH/q8NlQ/utN3B2Vpwvte5jDNrYZFK+zaCTseTPl6mx15vbQJx+C49rCIn4pKAU48
	GTWA+Z5fUqe38Vx9AZNrUCFDMqzVq4YWy9mgEOfZ6rFPkWb5NW4d+97c3RhL+ibbOoDZ9x1p0Cd
	diVnE7W
X-Received: by 2002:a05:6214:194d:b0:895:4852:ef55 with SMTP id 6a1803df08f44-89979d3b10emr224487636d6.33.1771963446716;
        Tue, 24 Feb 2026 12:04:06 -0800 (PST)
Received: from localhost.localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899b3863159sm7696406d6.24.2026.02.24.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 12:04:06 -0800 (PST)
Date: Tue, 24 Feb 2026 20:03:59 +0000
From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
To: Gregory Price <gourry@gourry.net>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
	Michal Koutny <mkoutny@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [RFC PATCH 0/6] mm/memcontrol: Make memcg limits tier-aware
Message-ID: <aZ4EL6IlaSi0KjT6@localhost.localhost>
References: <aZ2LC0KPF0xsAwAL@tiehlicka>
 <20260224161357.2622501-1-joshua.hahnjy@gmail.com>
 <aZ3ysV-k1UisnPRG@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ3ysV-k1UisnPRG@gourry-fedora-PF4VCD3F>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cs.cmu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cs.cmu.edu:s=google-2021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,cmpxchg.org,linux-foundation.org,kernel.org,oracle.com,google.com,linux.dev,redhat.com,huaweicloud.com,bytedance.com,kvack.org,vger.kernel.org,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14232-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cs.cmu.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiyang2@cs.cmu.edu,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A775E18C43C
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 01:49:21PM -0500, Gregory Price wrote:
> 
> > 
> > > Is this typical in real life configurations?
> > 
> > I would say so. I think that the two examples above are realistic
> > scenarios that cloud providers and hyperscalers might face on tiered systems.
> > 
> 
> The answer is unequivocally yes.
> 
> Lacking tier-awareness is actually a huge blocker for deploying mixed
> workloads on large, dense memory systems with multiple tiers (2+).

Hello! I'm the author of the RFC in 2024. Just want to add that we've
recently released a preprint paper on arXiv that includes case studies
with a few of Meta's production workloads using a prototype version of
the patches.

The results confirmed that co-colocated workloads can have working set
sizes exceeding the limited top-tier memory capacity given today's
server memory shapes and workload stacking settings, causing contention
of top-tier memory. Workloads see significant variations in tail
latency and throughput depending on the share of top-tier tier memory
they get, which this patch set will alleviate.

Best,
Kaiyang

[1] https://arxiv.org/pdf/2602.08800

