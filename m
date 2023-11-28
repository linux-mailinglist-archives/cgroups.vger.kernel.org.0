Return-Path: <cgroups+bounces-599-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C985A7FB5E1
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 10:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B552B217E0
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA68E495DE;
	Tue, 28 Nov 2023 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71804DE;
	Tue, 28 Nov 2023 01:32:52 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 211EB2198D;
	Tue, 28 Nov 2023 09:32:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED9751343E;
	Tue, 28 Nov 2023 09:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ALBEMsKzZWWUYAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 09:32:50 +0000
Date: Tue, 28 Nov 2023 10:32:50 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	kernel@sberdevices.ru, rockosov@gmail.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <ZWWzwhWnW1_iX0FP@tiehlicka>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
 <20231123193937.11628-3-ddrokosov@salutedevices.com>
 <ZWRifQgRR0570oDY@tiehlicka>
 <20231127113644.btg2xrcpjhq4cdgu@CAB-WSD-L081021>
 <ZWSQji7UDSYa1m5M@tiehlicka>
 <20231127161637.5eqxk7xjhhyr5tj4@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127161637.5eqxk7xjhhyr5tj4@CAB-WSD-L081021>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 211EB2198D

On Mon 27-11-23 19:16:37, Dmitry Rokosov wrote:
> On Mon, Nov 27, 2023 at 01:50:22PM +0100, Michal Hocko wrote:
> > On Mon 27-11-23 14:36:44, Dmitry Rokosov wrote:
> > > On Mon, Nov 27, 2023 at 10:33:49AM +0100, Michal Hocko wrote:
> > > > On Thu 23-11-23 22:39:37, Dmitry Rokosov wrote:
> > > > > The shrink_memcg flow plays a crucial role in memcg reclamation.
> > > > > Currently, it is not possible to trace this point from non-direct
> > > > > reclaim paths. However, direct reclaim has its own tracepoint, so there
> > > > > is no issue there. In certain cases, when debugging memcg pressure,
> > > > > developers may need to identify all potential requests for memcg
> > > > > reclamation including kswapd(). The patchset introduces the tracepoints
> > > > > mm_vmscan_memcg_shrink_{begin|end}() to address this problem.
> > > > > 
> > > > > Example of output in the kswapd context (non-direct reclaim):
> > > > >     kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > >     kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: nr_reclaimed=0 memcg=16
> > > > >     kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > >     kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: nr_reclaimed=1 memcg=16
> > > > >     kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > >     kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: nr_reclaimed=4 memcg=16
> > > > >     kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > >     kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: nr_reclaimed=11 memcg=16
> > > > >     kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > >     kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: nr_reclaimed=25 memcg=16
> > > > >     kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
> > > > >     kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: nr_reclaimed=53 memcg=16
> > > > 
> > > > In the previous version I have asked why do we need this specific
> > > > tracepoint when we already do have trace_mm_vmscan_lru_shrink_{in}active
> > > > which already give you a very good insight. That includes the number of
> > > > reclaimed pages but also more. I do see that we do not include memcg id
> > > > of the reclaimed LRU, but that shouldn't be a big problem to add, no?
> > > 
> > > >From my point of view, memcg reclaim includes two points: LRU shrink and
> > > slab shrink, as mentioned in the vmscan.c file.
> > > 
> > > 
> > > static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> > > ...
> > > 		reclaimed = sc->nr_reclaimed;
> > > 		scanned = sc->nr_scanned;
> > > 
> > > 		shrink_lruvec(lruvec, sc);
> > > 
> > > 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> > > 			    sc->priority);
> > > ...
> > > 
> > > So, both of these operations are important for understanding whether
> > > memcg reclaiming was successful or not, as well as its effectiveness. I
> > > believe it would be beneficial to summarize them, which is why I have
> > > created new tracepoints.
> > 
> > This sounds like nice to have rather than must. Put it differently. If
> > you make existing reclaim trace points memcg aware (print memcg id) then
> > what prevents you from making analysis you need?
> 
> You are right, nothing prevents me from making this analysis... but...
> 
> This approach does have some disadvantages:
> 1) It requires more changes to vmscan. At the very least, the memcg
> object should be forwarded to all subfunctions for LRU and SLAB
> shrinkers.

We should have lruvec or memcg available. lruvec_memcg() could be used
to get memcg from the lruvec. It might be more places to add the id but
arguably this would improve them to identify where the memory has been
scanned/reclaimed from.
 
> 2) With this approach, we will not have the ability to trace a situation
> where the kernel is requesting reclaim for a specific memcg, but due to
> limits issues, we are unable to run it.

I do not follow. Could you be more specific please?

> 3) LRU and SLAB shrinkers are too common places to handle memcg-related
> tasks. Additionally, memcg can be disabled in the kernel configuration.

Right. This could be all hidden in the tracing code. You simply do not
print memcg id when the controller is disabled. Or just simply print 0.
I do not really see any major problems with that.

I would really prefer to focus on that direction rather than adding
another begin/end tracepoint which overalaps with existing begin/end
traces and provides much more limited information because I would bet we
will have somebody complaining that mere nr_reclaimed is not sufficient.
-- 
Michal Hocko
SUSE Labs

