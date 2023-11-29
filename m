Return-Path: <cgroups+bounces-682-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154867FDDFD
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 18:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8D41C209AD
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40FD3D0A6;
	Wed, 29 Nov 2023 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c5lp+V55"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D27BC;
	Wed, 29 Nov 2023 09:10:35 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 486F7219B5;
	Wed, 29 Nov 2023 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701277834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vzwYMvZH+lLs7nIcf9848QxwWYfgK9k6V/VFPR/CPRo=;
	b=c5lp+V55CaoT+Xdq7Wwd+8OE9dGrFAn2IzXhIrl90H2aFxKRO6Ii6NJEzhC7kZQmNiA1RG
	cd9t4hK0Yg4/h5Z+6oIfZSu4CPnTItNmi9PW9op1hC60azk4mNv3lNiAKZZPZP4eAAUZ8j
	NputPfcch4/rlsKJdpGm3lxHYX0cirI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B94213637;
	Wed, 29 Nov 2023 17:10:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AycXA4pwZ2V1DgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 29 Nov 2023 17:10:34 +0000
Date: Wed, 29 Nov 2023 18:10:33 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, mhiramat@kernel.org,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, kernel@sberdevices.ru, rockosov@gmail.com,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <ZWdwifakPuMZbFUV@tiehlicka>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
 <20231123193937.11628-3-ddrokosov@salutedevices.com>
 <ZWRifQgRR0570oDY@tiehlicka>
 <20231127113644.btg2xrcpjhq4cdgu@CAB-WSD-L081021>
 <ZWSQji7UDSYa1m5M@tiehlicka>
 <20231127161637.5eqxk7xjhhyr5tj4@CAB-WSD-L081021>
 <ZWWzwhWnW1_iX0FP@tiehlicka>
 <20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
 <ZWdhjYPjbsoUE_mI@tiehlicka>
 <20231129165752.7r4o3jylbxrj7inb@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129165752.7r4o3jylbxrj7inb@CAB-WSD-L081021>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.993];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,goodmis.org,kernel.org,cmpxchg.org,linux.dev,google.com,sberdevices.ru,gmail.com,vger.kernel.org,kvack.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.80

On Wed 29-11-23 19:57:52, Dmitry Rokosov wrote:
> On Wed, Nov 29, 2023 at 05:06:37PM +0100, Michal Hocko wrote:
> > On Wed 29-11-23 18:20:57, Dmitry Rokosov wrote:
> > > On Tue, Nov 28, 2023 at 10:32:50AM +0100, Michal Hocko wrote:
> > > > On Mon 27-11-23 19:16:37, Dmitry Rokosov wrote:
> > [...]
> > > > > 2) With this approach, we will not have the ability to trace a situation
> > > > > where the kernel is requesting reclaim for a specific memcg, but due to
> > > > > limits issues, we are unable to run it.
> > > > 
> > > > I do not follow. Could you be more specific please?
> > > > 
> > > 
> > > I'm referring to a situation where kswapd() or another kernel mm code
> > > requests some reclaim pages from memcg, but memcg rejects it due to
> > > limits checkers. This occurs in the shrink_node_memcgs() function.
> > 
> > Ohh, you mean reclaim protection
> > 
> > > ===
> > > 		mem_cgroup_calculate_protection(target_memcg, memcg);
> > > 
> > > 		if (mem_cgroup_below_min(target_memcg, memcg)) {
> > > 			/*
> > > 			 * Hard protection.
> > > 			 * If there is no reclaimable memory, OOM.
> > > 			 */
> > > 			continue;
> > > 		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
> > > 			/*
> > > 			 * Soft protection.
> > > 			 * Respect the protection only as long as
> > > 			 * there is an unprotected supply
> > > 			 * of reclaimable memory from other cgroups.
> > > 			 */
> > > 			if (!sc->memcg_low_reclaim) {
> > > 				sc->memcg_low_skipped = 1;
> > > 				continue;
> > > 			}
> > > 			memcg_memory_event(memcg, MEMCG_LOW);
> > > 		}
> > > ===
> > > 
> > > With separate shrink begin()/end() tracepoints we can detect such
> > > problem.
> > 
> > How? You are only reporting the number of reclaimed pages and no
> > reclaimed pages could be not just because of low/min limits but
> > generally because of other reasons. You would need to report also the
> > number of scanned/isolated pages.
> >  
> 
> From my perspective, if memory control group (memcg) protection
> restrictions occur, we can identify them by the absence of the end()
> pair of begin(). Other reasons will have both tracepoints raised.

That is not really great way to detect that TBH. Trace events could be
lost and then you simply do not know what has happened.

-- 
Michal Hocko
SUSE Labs

