Return-Path: <cgroups+bounces-14606-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GTWNYpfqGmduAAAu9opvQ
	(envelope-from <cgroups+bounces-14606-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 17:36:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A5E20467B
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 17:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C9C3014BC6
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6836074B;
	Wed,  4 Mar 2026 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrltKoY9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB4366079
	for <cgroups@vger.kernel.org>; Wed,  4 Mar 2026 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641618; cv=none; b=B/+/gwLUOzuwk7zn3uDwGQRGEyHTeoaSnMAyCDr/uwCzPNH5czUxri+iy9hztEXrPZEW3bWsGcmZZqBMSDAgv4CGUW090KLmI6WkST+G1bkHJCwVltb3ohz98rAe82X7WrHjOaWPjLvrD4tWT+BLFyHwYzELIn5YjRy2jOvn6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641618; c=relaxed/simple;
	bh=eA7E7eZTn6WWCSz2VDvWTjTbPH+bebgGwzaVQ9OPJa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCyZnONeDbX4QLU+viOVA6ABJIrVpXhLcSoCQXmJMk0WZ0M6CqZFnsevf3zDHhwkFLZwVCCfk70+r9Zz9O6LYUXkTVkRVfUgpAJa0Xk35qAdQM/42i9lRQNJ7hg4oxG2mN8Zc2F6FS+zbllXTv6lJbcn9dFvvABvCu/bW3+mBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrltKoY9; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46394090d2fso2516599b6e.3
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2026 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772641614; x=1773246414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Hg+2cx4ctUEYaUblGwODgDafYhXfvGplcz0+hFdRQQ=;
        b=hrltKoY9WbyA+csyMCGezwa/+q0zLsbNf32HJnykOG2ayehe0BhB4hp9mExNfBHXHt
         DtBE16KpRAjiG/77oXx2scMJF9NbkHJ3XxHy9l3TZP3834+5CkMv0TYXMRZgnmA49QOx
         cmK0BVPl+y6I+mSlDaH3DgplWTr77Shqdlmzu6kUmxOoMJo5/W+2sT/IZ/ygIKIrKfb/
         MsEubCQVsjRAZ/LIj8B9wJjc422Q5wQHZbuDtSwCrZLOR7YV488LgVyQ/1LgSdZFEKE0
         O3ekfXfzbs+uccwxjAZMZcoOgR+nP6fiXgrgIVgIGMKsPEpqUqdzOckpgUjqFk3cLYBk
         MY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772641614; x=1773246414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Hg+2cx4ctUEYaUblGwODgDafYhXfvGplcz0+hFdRQQ=;
        b=dgAEO5+v9UeAeovPEVuubnlE89uZ1sM635wJBFstSGrMUSLavgLkPVYN5pGtWrqASk
         lHhnJPfQxWXUNIdXNIHJUUIgwe6dq5SGt9JLAaFbe5VRPMnbVZcmaPk61Ke8QzDVWWHY
         H2Xur/ZOZ2qANIZjS7Mmk2cM4c7alwXOTxOYr0UCSjLTigMlQeovkyPHf4g00jC2ISVg
         PbWmSXxrZtwvMLi36Oz3J0oJ/KshxPBgZvmYQOlDcvohKzn+Mf0/Y4PQ5A3p7FXPQQTl
         SKQb78x102hawvkKTZwhsG3gvYOFXRDZa3XROAlQhlX1ybSgHVoG1FmWiI3wJOcMFnNj
         QQvw==
X-Forwarded-Encrypted: i=1; AJvYcCXt6wxv8XxoKPKqklOualC4rusi2ndKKM57hJTNDK6BRoW+BiJSc1FsVKNcsCY+JXHhCr748Sds@vger.kernel.org
X-Gm-Message-State: AOJu0YzvR8lOhW3tlwwYU/fDVZdRGp4wJqeXmMHn3qiFLuzJ50wL15Wp
	S2ItPDeJ8EpCzw75eyMNNqohduv9vvZZVOeJ632hnADA1tlS46ouLI6E
X-Gm-Gg: ATEYQzy3DbtzG/0yFlUMwcqjipX6A+PJu1gnJjjg5HIzMV0wvDBNJjmfk0Z9zv2F9uZ
	J4E5S93vo1RFUCpIjbEge2Ki+TtnosJ6PtMYy8ZzQw8/cTxeIUEL0/oa89U54syqJHqOi/517Cr
	D5D08WVKDsWwh20Fp542LDE9UbVYRsEz6hAYFuyHWhMH89Lm+N43u8qUOQT9Pp80X6He9cpx0V8
	1rWdaYPbQLRYXY9ZI23fuWqH18ZU5n249HBjqawVyPxke8BO4OfKFw+njSSzYrgPFV+TwjI/2u3
	aT3Pv63779CS8YjwxC2JxgyUL2Z/A+UvLbpk7IH0H1k1Oe0WsQPT/6+h0aR9mYnWxuhpo+pv04D
	51kY5mr07S2IgXE9h8OBF5GNl4OamamVRr8J21sTnVMhIeVZJJ4yVcnIPHM3yLTrCa6R4WUbyr6
	DTkHPcljaDkKdGet/s+LHk
X-Received: by 2002:a05:6808:22ac:b0:450:3e21:f567 with SMTP id 5614622812f47-4651ad0d5aamr1135266b6e.56.1772641614328;
        Wed, 04 Mar 2026 08:26:54 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb4028cdsm11886351b6e.9.2026.03.04.08.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:26:53 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 6/8] mm/zsmalloc, zswap: Handle objcg charging and lifetime in zsmalloc
Date: Wed,  4 Mar 2026 08:26:50 -0800
Message-ID: <20260304162652.335793-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAO9r8zOJ5bkJzptM7+8V2G00dHuycAEAF4CDcaR1YMk0kWyktA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 79A5E20467B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14606-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,chromium.org,cmpxchg.org,linux.dev,gmail.com,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 07:46:48 -0800 Yosry Ahmed <yosry@kernel.org> wrote:

> On Wed, Mar 4, 2026 at 7:11 AM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> >
> > On Tue, 3 Mar 2026 15:53:31 -0800 Yosry Ahmed <yosry@kernel.org> wrote:
> >
> > > > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > > > index 067215a6ddcc..88c7cd399261 100644
> > > > --- a/mm/zsmalloc.c
> > > > +++ b/mm/zsmalloc.c
> > > > @@ -963,6 +963,44 @@ static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
> > > >         return true;
> > > >  }
> > > >
> > > > +static void zs_charge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
> > > > +                           int size, unsigned long offset)
> > > > +{
> > > > +       struct mem_cgroup *memcg;
> > > > +
> > > > +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > > +               return;
> > > > +
> > > > +       VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
> > > > +
> > > > +       /* PF_MEMALLOC context, charging must succeed */
> > > > +       if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
> > > > +               VM_WARN_ON_ONCE(1);
> > > > +
> > > > +       rcu_read_lock();
> > > > +       memcg = obj_cgroup_memcg(objcg);
> > > > +       mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
> > > > +       mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
> >
> > Hello Yosry, I hope you are doing well!
> > Thank you for your feedback : -)
> >
> > > Zsmalloc should not be updating zswap stats (e.g. in case zram starts
> > > supporting memcg charging).  How about moving the stat updates to
> > > zswap?
> >
> > Yeah... I think this was also a big point of concern for me. While reading
> > the code, I was really amazed by how clean the logical divide between
> > zsmalloc and zswap / zram were, and I wanted to preserve it as much as
> > possible.
> >
> > There are a few problems, though. Probably the biggest is that migration
> > of zpdescs and compressed objects within them are invisible to zswap.
> > Of course, this is by design, but this leads to two problems.
> >
> > zswap's ignorance of compressed objects' movements across physical nodes
> > makes it impossible to accurately charge and uncharge from the correct
> > memcg-lruvec.
> >
> > Conversely, zsmalloc's ignorance of memcg association makes it impossible
> > to correctly restrict cpusets.mems during migration.
> >
> > So the clean logical divide makes a lot of sense for separating the
> > high-level cgroup association, compression, etc. from the physical
> > location of the memory and migration / zpdesc compaction, but it would
> > appear that this comes at a cost of oversimplifying the logic and missing
> > out on accurate memory charging and a unified source of truth for the
> > counters.
> >
> > The last thing I wanted to note was that I agree that zsmalloc doing
> > explicit zswap stat updates feels a bit awkward. The reason I chose to do
> > this right now is because when enlightening zsmalloc about the compressed
> > objs' objcgs, zswap is the only one that does this memory accounting.
> > So having an objcg is a bit of a proxy to understand that the consumer
> > is zswap (as opposed to zram). Of course, if zram starts to do memcg
> > accounting as well, we'll have to start doing some other checks to
> > see if the compresed object should be accounted as zram or zswap.
> >
> > OK. That's all the defense I have for my design : -) Now for thinking
> > about other designs:
> >
> > I also explored whether it makes sense to make zsmalloc call a hook into
> > zswap code during and after migrations. The problem is that there isn't
> > a good way to do the compressed object --> zswap entry lookup, and this
> > still doesn't solve the issue of zsmalloc migrating compressed objects
> > without checking whether that object can live on another node.
> >
> > Maybe one possible approach is to turn the array of objcgs into an array
> > of backpointers from compressed objects to their corresponding zswap_entries?
> > One concern is that this does add 8 bytes of additional overhead per
> > zswap entry, and I'm not sure that this is acceptable. I'll keep thinking
> > on whether there's a creative way to save some memory here, though...
> >
> > Of course the other concern is what this will look like for zram users.
> > I guess it can be done similarly to what is done here, and only allocate
> > the array of pointers when called in from zswap.
> >
> > Anyways, thank you for bringing this up. What do you think about the
> > options we have here? I hope that I've motivated why we want
> > per-memcg-lruvec accounting as well. Please let me know if there is anything
> > I can provide additional context for : -)
> 
> Thanks for the detailed elaboration.
> 
> AFAICT the only zswap-specific part is the actual stat indexes, what
> if these are parameterized at the zsmalloc pool level? AFAICT zswap
> and zram will never share a pool.

That's a great idea, we can abstract the ZSWAP and ZSWAPPED idxs as
"compressed" and "uncompressed" and leave the flexibility for zram
to do similar accounting in the future if they wish to.

Thanks for the suggestion, Yosry. I'll include this in the v2 and
send it out! I hope you have a great day!!
Joshua

