Return-Path: <cgroups+bounces-16628-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IynbAr+AIGq44QAAu9opvQ
	(envelope-from <cgroups+bounces-16628-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 21:30:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D263ADCB
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 21:30:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BuoT7f99;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16628-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16628-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54BD63057778
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 19:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60748BD2D;
	Wed,  3 Jun 2026 19:26:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BB48B373
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 19:26:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514782; cv=pass; b=bRPyJQfeM+0kTsXwCBMMKR6H2AB2dk/qF3cvoQmB9Pj0gfOHJgNFGY4Q/EUk8a03I8TPsZTs9a9HuNurbRgZp24NmttUdj2XcTbN82wEWCXsKT36PlnBwHfExlSxlBNWPINnXpHZEKS0xqOJyua+g7xCgKSH2iymua7goTBnkow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514782; c=relaxed/simple;
	bh=tBlqGSO58iqBVZZw/2Y2ObnnEsd9OBRWmhZbqa08LGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kS4o8acFucI0lAW5lbVjClW/lsyWtpCs2a2TlA0hxwH/0ZbhfD9ccPFQYpy0hav0UTLxK3kjoDIrHTKYAzooI2KuYKT5nlvIQ9AmZ8LWt8KoCp6YE2a0nG+Aq51BxtVoWexS/63aggWv1w9FeSvva6V4mlAB8qYEVLcwWlW6wJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuoT7f99; arc=pass smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-46013161068so1994558f8f.2
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 12:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780514779; cv=none;
        d=google.com; s=arc-20240605;
        b=knQvYY/a3uVEWVKyRPzVSzKsP0b//cHL376i/Q28AK741WFWENonaWUdiq58J4Y4IZ
         3tEX70scgSO36p2UKrFQ2QEZrG9mKJSkNd0YuGa0xbl4WNtSLha+/3EYwtJHs+VbakPc
         Nq6FXMpLmarTzsrgLCpG4uQ7Q86Cz2hjmT3LC2XZ7zVXFPBVj3WPZfUNh9RIFvcU+6+z
         C8R84PEzgY4SSdVkCnJOdIRl5pCCE6AC/kyFLrQkEGj8nuzMTqsUtQ6Vtg/0fjnUXrWV
         OKsB9CJP3WqsuxJhvUtGu4X6hxb7POAea7dtmFmXrVc945UfrjwlRuCMumQZLsNe9x6P
         1dAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tBlqGSO58iqBVZZw/2Y2ObnnEsd9OBRWmhZbqa08LGQ=;
        fh=abHu2HC3+0h1qr2Za67XfnYap/ujScwrLf0SAR/gi/g=;
        b=TK2405vXLdik8236gZ6K7Dm44X9NRIjt4h6ld/kdjP/ppOOVfJRu8//vCGzIqicIeH
         r5ofhZwGZgQHl9vjU2JROyZ7YcJDb1sedQznXoJap4ZK0txQk8zYaH51FEdMezMCjAiR
         9ZlVmCrVlXHVqGSJZyfODGp2vDyDb1istHiTAe5FDMA+e19auZAeFb+dPkQAWKHFDI0j
         qOKZhN/pTvfO5r2nOGOcF7yVYGi6RKxmGrYg/8mZQCqtZMtZWRy21HknH0RR4+7W1FJh
         ZbC62ky0vHrFfQ3rdVjNXx1IGMtfi3oHTSzsNS+cmgho0TNg+AQ5Cpvf70IkAMragz7f
         jjXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780514779; x=1781119579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBlqGSO58iqBVZZw/2Y2ObnnEsd9OBRWmhZbqa08LGQ=;
        b=BuoT7f99eJZTXtIIe4MFO5di5KxU7NumGnwQirtPVBW46zq9F/ZSOik/hoFJlFSSjQ
         o87B/LO9s6P3tFSplzk1Iub761YlykrTPGjuYTWWYYYITgivDoZPGarj/3u6AhK+u/NS
         Y8w6xejTVTKQqVRBP2pch/fFfF8YEvV3nBOSvFDgBLEjU2Cj5NBmXoKaouAtdzd5HUyb
         u51gW/lhPRaqsV8y3o+CeDt3ubI3aoDYboIo12tQiJc4lGby/MA4Gn1ZuRrRynWWYzhq
         Vq8ljUF/jchmhR3ohUvN1q7zHi+bwj/iHLKdFdaOORcq5UGb+HTOTiNknJP7WJX7mRNq
         LpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780514779; x=1781119579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tBlqGSO58iqBVZZw/2Y2ObnnEsd9OBRWmhZbqa08LGQ=;
        b=RIO4DoGplrBtpLHWnkAW1AegIwXTLLf+vFItfHAfDjg4rURcS1o+lYLII/a9QrPcby
         M2c8XgohGDaQnwxUP20S5QQXNg/nz/pUp8z9h9uP6imft/nLzlt4I8nQFsssiStK2WqW
         nQXfPpj54c1EmxX70CJIJ5XgEmo0b46a/eYyqeAFABQJIVTDhNoHokWrHuWN4oMdGbHG
         Kbuw77VLcTZo8mJlwHzawld1vO3kP4jCo+Wb81UlMeTtcKtJ7vP23/+7Qm7eJb2XokF8
         VQDGo2Wmk+iw6xuVC/ZOuBE6ZhpGcC9nZuZaOlIYKjvzgUeSV1yisNxMiu/IeaJXS+G/
         jHAA==
X-Forwarded-Encrypted: i=1; AFNElJ8ixPsQ8Fv2UrNtw7NgliUj0NBnWsxGhRvQB5Fwlt4d5ytqkf5Nf5JS+a4bmauRpDoF3862twUN@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgqB1RkXy9XK/3PkDGtc/GgH0Utv+M+G03Qfx4NJCXMlEiBAi
	DkXodZYm+ccjU/bmctMqGGQfWFtXryw0NvYbSAJ+y6qZ4AaYTd05VU4eL6bn5z06LjXjR0FTdfS
	/SWj4rO3JZ2+3mnYHJcpCABe2ld601FI=
X-Gm-Gg: Acq92OEgBLL19+s5E6aPGV+yUm/oQhN4Cvg8PxeSEbwkU1WNqxEnH/oGjHuR618V+/7
	lLT1IQQ+1CkVTfi+1taagFvhbDlONm+4zud4jJT5Y/dTG8V0j037lLm1aHfnCQPin/WK3LpDOAT
	wf9RzvHYHCuetRVo+tgwOp3yFA3LEzU/nbqAVHbHP3bG2KHqGtG3XLX4hUn8y+TyYYi34pFdo5O
	y4cz87+2udy43DxajgcZiwcr44SprSrsoQ2qwc+E8WjBMppQq7LnHwv9ibHM4r81HDa1WGFtOJG
	FCkO4Xdfo7IAVc6tqMP//akTDb9/QpR/ZNc/rmn27GQtrnjA0g==
X-Received: by 2002:a05:6000:1288:b0:45a:e3dd:5865 with SMTP id
 ffacd0b85a97d-4602179d1femr5352008f8f.13.1780514779097; Wed, 03 Jun 2026
 12:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ah-A2gQ0GPgerXop@google.com>
 <CAKEwX=MWX9KkSFAoN4xEMg3b+gZUN9=yd7rirAWG5NOBf26eAg@mail.gmail.com> <aiB2sHqxcBAJrTkP@google.com>
In-Reply-To: <aiB2sHqxcBAJrTkP@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 3 Jun 2026 12:26:07 -0700
X-Gm-Features: AVHnY4KHcbe_bXQiAXNFeQa4TOqhlLT5AHoq3gLwnZPa6MV4BsBjJQBU0kZ4pYI
Message-ID: <CAKEwX=P95D7wNpWhEAXQpeNPM6eQa2mEZE8Srzfpct=-=Q40tg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Yosry Ahmed <yosry@kernel.org>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	corbet@lwn.net, david@kernel.org, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com, haowenchao22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16628-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:kasong@tencent.com,m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:bhe@redhat.com,m:byungchul@sk.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:chrisl@kernel.org,m:corbet@lwn.net,m:david@kernel.org,m:dev.jain@arm.com,m:gourry@gourry.net,m:hannes@cmpxchg.org,m:hughd@google.com,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:lenb@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-pm@vger.kernel.org,m:lorenzo.stoakes@oracle.com,m:matthew.brost@intel.com,m:mhocko@suse.com,m:muchun.song@linux.dev,m:npache@redhat.com,m:pavel@kernel.org,m:peterx@redhat.com,m:peterz@infradead.org,m:pfalcato@suse.de,m:rafael@kernel.org,m:rakie.kim@sk.com,m:roman.gushchin@linux.dev,m:rppt@kernel.org,m:ryan.roberts@arm.com,m:shakeel.butt@linux.dev,m:shikemeng@huaweicloud.com,m:su
 renb@google.com,m:tglx@kernel.org,m:vbabka@suse.cz,m:weixugc@google.com,m:ying.huang@linux.alibaba.com,m:yosry.ahmed@linux.dev,m:yuanchu@google.com,m:zhengqi.arch@bytedance.com,m:ziy@nvidia.com,m:kernel-team@meta.com,m:riel@surriel.com,m:haowenchao22@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E7D263ADCB

On Wed, Jun 3, 2026 at 11:58=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> > > I assume the main reason here is to avoid the extra overhead if
> > > everything uses vswap, which would mainly be the reverse mapping
> > > overhead? I guess there's also some simplicity that comes from reusin=
g
> > > the swap info infra as a whole, including the swap table.
> >
> > Yeah it helps a lot that we don't have to rewrite the whole allocator
> > and swap entry reference counting logic again :)
>
> I specifically meant using a full swap info thing for the physical swap
> device even when it's behind vswap. That seems like an overkill, and we
> don't need things like the swap entry reference coutning. We probably
> just need a bitmap and a reverse mapping.
>
> So I am assuming the main reason why we are not doing that (at least for
> now) is simplicity?

Mostly.

FWIW, we're pretty close to full deduplication. Right now, physical
swap clusters have a couple of fields that are not needed when they're
backing a vswap cluster:

1. The main swap table (which houses swap cache, swap shadow, and
reference counting): I repurpose it for the rmap :) It's an array of
unsigned long, which works for rmap.

2. memcg_table: still duplicated, but I think I can make sure this is
not allocated if physical swap clusters only back vswap entries. I
have a prototype that I'm testing for this.

3. The zeromap field: this is actually not allocated in 64 bit
architecture, IIUC, which is what I'm gating CONFIG_VSWAP on. If we
extend vswap to supporting 32 bits, this can also be dynamically
allocated.

4. Extend table - this is for the swap count overfills, and already
dynamically allocated.

>
> > >
> > > I don't like that the code bifurcates for vswap vs. normal swap entri=
es
> > > though. Not sure if this is an issue that can be fixed with proper
> > > abstractions to hide it, or if the design needs modifications. I was
> > > honestly really hoping we don't end up with this. I was hoping that t=
he
> > > physical swap device no longer uses a full swap table and all, and
> > > everything goes through vswap.
> > >
> > > I hoping that if redirection isn't needed (e.g. zswap is disabled),
> > > vswap can directly encode the physical swap slot so that the reverse
> > > mapping isn't needed -- so we avoid the overhead without keeping the
> > > physical swap device using a fully-fledged swap table.
> >
> > Can you expand on "vswap can directly encode the physical swap slot"?
> > I'm not sure I follow here.
>
> I meant that if redirection is not needed (e.g. zswap is disabled), then
> instead of having a vswap device pointing at a physical swap device, we
> can just the data (e.g. phyiscal swap slot) in the vswap device
> directly. Then we don't need a full swap info thing and swap table for
> the physical swap device.
>
> This directly ties into my question above, about why we have a
> fully-fledged swap info thing for the physical swap device when using
> vswap.

See above.

>
> > >
> > > All that being said, perhaps I am too out of touch with the code to
> > > realize it's simply not possible.
> > >
> > > Honestly, if the main reason we can't have a single swap table for vs=
wap
> > > is saving 8 bytes on the reverse mapping, it sounds like a weak-ish
> > > argument, even if we can't optimize the reverse mapping away. But may=
be
> > > I am also out of touch with RAM prices :)
> >
> > In terms of the space overhead I do agree, FWIW :)
> >
> > I think the other concern is the indirection overhead with going
> > through the xarray for every swap operation, hence the per-CPU vswap
> > cluster lookup caching idea:
> >
> > https://lore.kernel.org/all/20260505153854.1612033-23-nphamcs@gmail.com=
/
>
> Right, but we should already avoid the xarray with the swap table
> design, right? We just have one swap table pointing to another
> essentially?

Hmmm, I don't quite follow your suggestion here.

For normal swap devices, we organize the space into clusters, and
maintain them in various lists (free, nonfull, full etc.). The only
difference with a vswap device is we do not have a free list, and have
the clusters themselves dynamically allocated.

If we're using vswap, we will incur the xarray overhead. There's no
avoiding that if we want a dynamic indirection layer. We can of course
revisit this data structure design later.

So yes, it will be one swap table (vswap cluster) pointing to another
swap table (pswap cluster). But to get to the first swap table, you
will have to go through xarray still.

>
> > >
> > > I at least hope that, the current design is not painting us into a
> > > corner (e.g. through userspace interfaces), and we can still achieve =
a
> > > vswap-for-all implementation in the future (maybe that's what you hav=
e
> > > in mind already?).
> >
> > That's still my plan. Operationally speaking, I want to make this
> > completely transparent to users, with minimal to no performance
> > overhead.
>
> So if CONFIG_VSWAP is set all swap devices are vswap by default, right?
> Would it help with testing if it's controlled by a boot param?
>
> >
> > The next action item is to optimize for vswap-on-fast-swapfile case -
> > that was Kairui's main concerns regarding performance. I spent a lot
> > of time perfing and fixing issues for this case in v6. The issues with
> > the most egregious effects and simplest fix (vswap-less
> > swap-cache-only check for e.g) are already fixed in this new design,
> > and eventually I will move the rest (lookup caching) and more to here.
>
> So is the end goal to have vswap be the default rather than a special
> swap device? It would certainly help to include some details about that.

That is my preference - I did allude to it in "Runtime enable/disable
of the vswap device" follow-up section :) I'm a sucker for unified
paths. It kinda depends on whether we can optimize most of vswap
overhead away though - if not, then we have to maintain both paths.
Kairui, how do you feel about this?

>
> > >
> > > Aside from the swap code, the only sticking point for me is the logic
> > > bifurcation in zswap. Why does zswap need to handle vswap vs. not vsw=
ap?
> > > I thought the point of the design is to use vswap when zswap is used,
> > > and otherwise use a normal swap table. In a way, one of the goals is =
to
> > > make zswap a first class swap citizen, but it doesn't seem like we ar=
e
> > > achieving that?
> >
> > We already have all the machinery to make zswap completely
> > independent. Right now, if you use vswap, you'll skip the zswap's
> > internal xarray entirely, and just store a zswap entry in the virtual
> > swap cluster's vtable.
> >
> > I just haven't removed the old code for 2 reasons:
> >
> > 1. Reduce the delta on this RFC, to ease the burden for reviewers (and
> > definitely not because I'm lazy :P)
> >
> > 2. The only other practical reason is so that we can let users compile
> > with !CONFIG_VSWAP and still uses zswap on top of the old swapfile
> > setup during the transition/experimentation period for now.
> >
> > But logically and conceptually speaking, there is no reason I can come
> > up with to use zswap on without vswap. The CPU indirection overhead is
> > already partially there (since zswap uses an xarray) and further
> > optimized (cluster loopup caching etc.), as well as the space overhead
> > (vswap replaces the zswap xarray). I actually wrote a whole paragraph
> > about how we should always go for vswap if we're using zswap, but then
> > decide to remove it since there's no code for it yet.
> >
> > If folks like it, what I can do is have CONFIG_ZSWAP depends on
> > CONFIG_VSWAP, removes all the non-vswap logic, and call it a day? :)
> > Then, on the swap allocation side, if vswap allocation fail and zswap
> > writeback is disabled, we can error out early.
>
> Hmm maybe we can keep it around for now and do that after vswap
> stabilizes? It ultimately depend on how much complexity we maintain by
> allowing both.
>
> I think another problem is 32-bit, technically zswap can be used on
> 32-bit now, right? So vswap not supporitng 32-bit is a problem.

Ah shoot I forgot about that. Hmmm.

It's not impossible to make vswap support 32-bit. I did that for v6
after all. It just needs extra fields because we have fewer bits to
leverage in pointers etc., complicating the logic a bit. Follow-up
work? :)

>
> General question (for both zswap and general swap code), would a boot
> param make implementation simpler? Right now we seem to key off the swap
> device having the "vswap" flag, would it help if it was a runtime
> constant?

Hmmm, even if it's a runtime constant, both branches still have to be
there, no? Does the boot param simplify it somehow?

