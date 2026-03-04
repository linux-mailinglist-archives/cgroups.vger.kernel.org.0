Return-Path: <cgroups+bounces-14604-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMfxMiVPqGmVtAAAu9opvQ
	(envelope-from <cgroups+bounces-14604-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 16:26:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F12029F2
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 16:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93F2B315505A
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE6C31F989;
	Wed,  4 Mar 2026 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc2pIY/9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8AF32D42B
	for <cgroups@vger.kernel.org>; Wed,  4 Mar 2026 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637086; cv=none; b=ADIc0OlmEDYYSPmzM79lbSmJvLnuS42+slIOaEx+pe6OnlV6N+jZEfv9AA77bQQjQMz983ip+N/adhvSKsBrUk5wH/db/6uTb1KAkng/1jbO1enX8b2VhUEY4gwp/ycB6qwINupDqFiZnuXMm/p0IbTmeuIgHJIT7SciKyh5UBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637086; c=relaxed/simple;
	bh=V0oPLGegAhTc4L7WHvwIBZ0RDMLRRcbNO/H/6P29W7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajy1lloShaQ9YGYVC7BVoKJEGD9dmKn42yK/hJ7gVSJ4I4Nbv1kIPYvPzNhNu+FLcCkMs5krdlIzu8brBD6C5v9N8aLoS+VM9KKXIJSc2HCSUvu7mTgIEbZtEDzcpqrz4m6lDoCGfMGZpXyCZJivv6Q3UzNzIb72Ri+jRc/IeHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc2pIY/9; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d18c654458so3379795a34.3
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2026 07:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772637082; x=1773241882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoKsT5JRqIpY8UANHFptI+GVlx4Jt8dOkJklplEKYw4=;
        b=Lc2pIY/9RTwoj50ViRSox8PwOi5H+ZeP6ZsXlXNTZSyjLum+lwcxYRWTzoOPlyiJeE
         Cdn2MBEiMuQZSduXp5Q9cIH8OcogiF+8HGeXP4dSoO3p5epk7OyWhKelcSbEr87Si1hN
         kIidGE0jc7vZrz6Rm7QMk2vh8tljdf70snr/WQM8P9+lcqgvpRmgEJ/84wiLs10ewUF7
         yl0lWk5x/1AUPE65HVks1XFm/b8wcXEYPb49yyuXuJccuCbhUZO8ccvsOhiskAea/kUS
         KN9gszAXpKsfJeSg9gh8/tEZLZcYX+Xfl5GIig5nnwzKddOeRefR8EiMpWatruLGDC7Y
         g9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772637082; x=1773241882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QoKsT5JRqIpY8UANHFptI+GVlx4Jt8dOkJklplEKYw4=;
        b=OgGwkGh4d3wF6YBNaPxkQiT/XCu6Ixw2yINlzkPGwEX+GPV8tDVXpW7eZ7s3qYc1vb
         QAsAn2vZjOd3l5TTZD/LuzYIIOJNKaBaffnV6vNUoovMJ58ldx6aNbMTT8Y4qs40C6bq
         iZKrbG6zosGAeO7kzxwiAfhXsAxAVBz0/fV36g9YZsSrvb36RFvqoo1XpQyK2Ooa4MOX
         V9X3ZeE+/NuqDvjnM9KOM0TvqTornz8CS9uTiFmCoIbUwxElVwS1umJ4UKKjLv+j91C0
         3ck+n36M9alsmAhtcaYTbLF1+CvYheeZKWWt3gKPKiSQj79zvwpRdkHg73CVUomLRC2p
         U0ww==
X-Forwarded-Encrypted: i=1; AJvYcCUrB3bXnYq3w4SG2+FcoEInpjLHHUQh3UGQCn+M6CWECNnejnUK5hvznQ0wYeOJfNIwC256Wusf@vger.kernel.org
X-Gm-Message-State: AOJu0YxMrfELSZPbDFCyudVPzhdfBnCIOMC1rc3hVMEbXqTvOp3s1aXo
	9tbBvmnPTKUQv+fKL/dF8yXD1NOb1S/xA+22gBukB51qI+U3AMpZDBgKxradlw==
X-Gm-Gg: ATEYQzx0UtMJQ7AMeRCqZZfj9iEfVcduZmlmBy6zgYao13i4yszQEWW9U0DuuiLKXcQ
	pNrJzFWy102tWxkcq5vElS8kRuiEEqILFP6KoG7IMXx2OOK9kGt9gQAQv8QR8F9OQmDXROUnAHD
	9LtLhqEVSRzOuz21gDyBMb8cevs2MCChn9Em8mSZruhatRhBKFRyx6IxL+EIO6HTuk4iay3twzo
	SeFSUXnGiUag+awbn/ZXTZAGQFfRSd+hY663DJsoh8L/Jg5Fk/S3nLL57bM+U63u5u1X0NKuod0
	Au9kNz9g0CSPgVOF+wwINYR5IVzsq9WlFxOUw0i0pgjHccR+ftqSB+vcQ8vOX7u65RXrMj1v0xy
	ls4YYzQjrAf21/czaPSTN31KAYAupws3YdeDg4hlwZMI350uN19ZWi4sWsSbDat9XvdCxw7ecej
	iWHlW8ERolEMyolnZV4o/ltw==
X-Received: by 2002:a05:6830:388c:b0:7d1:90d6:1f5c with SMTP id 46e09a7af769-7d6c7f4bc25mr1088903a34.4.1772637082089;
        Wed, 04 Mar 2026 07:11:22 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866701cdsm15564292a34.29.2026.03.04.07.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:11:21 -0800 (PST)
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
Date: Wed,  4 Mar 2026 07:11:19 -0800
Message-ID: <20260304151120.3512645-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAO9r8zOFS7zU-eGkErcjud=DW0t00_WqNqCzq_QDf061dOsYSQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E4F12029F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,chromium.org,cmpxchg.org,linux.dev,gmail.com,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	TAGGED_FROM(0.00)[bounces-14604-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 3 Mar 2026 15:53:31 -0800 Yosry Ahmed <yosry@kernel.org> wrote:

> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 067215a6ddcc..88c7cd399261 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -963,6 +963,44 @@ static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
> >         return true;
> >  }
> >
> > +static void zs_charge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
> > +                           int size, unsigned long offset)
> > +{
> > +       struct mem_cgroup *memcg;
> > +
> > +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > +               return;
> > +
> > +       VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
> > +
> > +       /* PF_MEMALLOC context, charging must succeed */
> > +       if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
> > +               VM_WARN_ON_ONCE(1);
> > +
> > +       rcu_read_lock();
> > +       memcg = obj_cgroup_memcg(objcg);
> > +       mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
> > +       mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);

Hello Yosry, I hope you are doing well!
Thank you for your feedback : -)

> Zsmalloc should not be updating zswap stats (e.g. in case zram starts
> supporting memcg charging).  How about moving the stat updates to
> zswap?

Yeah... I think this was also a big point of concern for me. While reading
the code, I was really amazed by how clean the logical divide between
zsmalloc and zswap / zram were, and I wanted to preserve it as much as
possible.

There are a few problems, though. Probably the biggest is that migration
of zpdescs and compressed objects within them are invisible to zswap.
Of course, this is by design, but this leads to two problems.

zswap's ignorance of compressed objects' movements across physical nodes
makes it impossible to accurately charge and uncharge from the correct
memcg-lruvec.

Conversely, zsmalloc's ignorance of memcg association makes it impossible
to correctly restrict cpusets.mems during migration.

So the clean logical divide makes a lot of sense for separating the
high-level cgroup association, compression, etc. from the physical
location of the memory and migration / zpdesc compaction, but it would
appear that this comes at a cost of oversimplifying the logic and missing
out on accurate memory charging and a unified source of truth for the
counters.

The last thing I wanted to note was that I agree that zsmalloc doing
explicit zswap stat updates feels a bit awkward. The reason I chose to do
this right now is because when enlightening zsmalloc about the compressed
objs' objcgs, zswap is the only one that does this memory accounting.
So having an objcg is a bit of a proxy to understand that the consumer
is zswap (as opposed to zram). Of course, if zram starts to do memcg
accounting as well, we'll have to start doing some other checks to
see if the compresed object should be accounted as zram or zswap.

OK. That's all the defense I have for my design : -) Now for thinking
about other designs:

I also explored whether it makes sense to make zsmalloc call a hook into
zswap code during and after migrations. The problem is that there isn't
a good way to do the compressed object --> zswap entry lookup, and this
still doesn't solve the issue of zsmalloc migrating compressed objects
without checking whether that object can live on another node.

Maybe one possible approach is to turn the array of objcgs into an array
of backpointers from compressed objects to their corresponding zswap_entries?
One concern is that this does add 8 bytes of additional overhead per 
zswap entry, and I'm not sure that this is acceptable. I'll keep thinking
on whether there's a creative way to save some memory here, though...

Of course the other concern is what this will look like for zram users.
I guess it can be done similarly to what is done here, and only allocate
the array of pointers when called in from zswap.

Anyways, thank you for bringing this up. What do you think about the
options we have here? I hope that I've motivated why we want
per-memcg-lruvec accounting as well. Please let me know if there is anything
I can provide additional context for : -)

Have a great day!
Joshua

