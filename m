Return-Path: <cgroups+bounces-677-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6737FDC31
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 17:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00841C2098B
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AB139879;
	Wed, 29 Nov 2023 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47692BF;
	Wed, 29 Nov 2023 08:06:55 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB71D1FB40;
	Wed, 29 Nov 2023 16:06:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86CD61388B;
	Wed, 29 Nov 2023 16:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P5KmHZ1hZ2VffAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 29 Nov 2023 16:06:53 +0000
Date: Wed, 29 Nov 2023 17:06:37 +0100
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
Message-ID: <ZWdhjYPjbsoUE_mI@tiehlicka>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
 <20231123193937.11628-3-ddrokosov@salutedevices.com>
 <ZWRifQgRR0570oDY@tiehlicka>
 <20231127113644.btg2xrcpjhq4cdgu@CAB-WSD-L081021>
 <ZWSQji7UDSYa1m5M@tiehlicka>
 <20231127161637.5eqxk7xjhhyr5tj4@CAB-WSD-L081021>
 <ZWWzwhWnW1_iX0FP@tiehlicka>
 <20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out2.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[goodmis.org,kernel.org,cmpxchg.org,linux.dev,google.com,linux-foundation.org,sberdevices.ru,gmail.com,vger.kernel.org,kvack.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: AB71D1FB40
X-Spam: Yes

On Wed 29-11-23 18:20:57, Dmitry Rokosov wrote:
> On Tue, Nov 28, 2023 at 10:32:50AM +0100, Michal Hocko wrote:
> > On Mon 27-11-23 19:16:37, Dmitry Rokosov wrote:
[...]
> > > 2) With this approach, we will not have the ability to trace a situation
> > > where the kernel is requesting reclaim for a specific memcg, but due to
> > > limits issues, we are unable to run it.
> > 
> > I do not follow. Could you be more specific please?
> > 
> 
> I'm referring to a situation where kswapd() or another kernel mm code
> requests some reclaim pages from memcg, but memcg rejects it due to
> limits checkers. This occurs in the shrink_node_memcgs() function.

Ohh, you mean reclaim protection

> ===
> 		mem_cgroup_calculate_protection(target_memcg, memcg);
> 
> 		if (mem_cgroup_below_min(target_memcg, memcg)) {
> 			/*
> 			 * Hard protection.
> 			 * If there is no reclaimable memory, OOM.
> 			 */
> 			continue;
> 		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
> 			/*
> 			 * Soft protection.
> 			 * Respect the protection only as long as
> 			 * there is an unprotected supply
> 			 * of reclaimable memory from other cgroups.
> 			 */
> 			if (!sc->memcg_low_reclaim) {
> 				sc->memcg_low_skipped = 1;
> 				continue;
> 			}
> 			memcg_memory_event(memcg, MEMCG_LOW);
> 		}
> ===
> 
> With separate shrink begin()/end() tracepoints we can detect such
> problem.

How? You are only reporting the number of reclaimed pages and no
reclaimed pages could be not just because of low/min limits but
generally because of other reasons. You would need to report also the
number of scanned/isolated pages.
 
> > > 3) LRU and SLAB shrinkers are too common places to handle memcg-related
> > > tasks. Additionally, memcg can be disabled in the kernel configuration.
> > 
> > Right. This could be all hidden in the tracing code. You simply do not
> > print memcg id when the controller is disabled. Or just simply print 0.
> > I do not really see any major problems with that.
> > 
> > I would really prefer to focus on that direction rather than adding
> > another begin/end tracepoint which overalaps with existing begin/end
> > traces and provides much more limited information because I would bet we
> > will have somebody complaining that mere nr_reclaimed is not sufficient.
> 
> Okay, I will try to prepare a new patch version with memcg printing from
> lruvec and slab tracepoints.
> 
> Then Andrew should drop the previous patchsets, I suppose. Please advise
> on the correct workflow steps here.

Andrew usually just drops the patch from his tree and it will disappaer
from the linux-next as well.
-- 
Michal Hocko
SUSE Labs

