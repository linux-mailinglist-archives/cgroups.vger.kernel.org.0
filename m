Return-Path: <cgroups+bounces-319-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058137E7A6B
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 10:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366691C20D69
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6184D526;
	Fri, 10 Nov 2023 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sne0KqHq"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096CAD506;
	Fri, 10 Nov 2023 09:06:00 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE5BAF9D;
	Fri, 10 Nov 2023 01:05:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F65621985;
	Fri, 10 Nov 2023 09:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699607158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8N0qgXB3RuUcX93UjUsbFRBaIloZQvm/KDkU0Ajtwn8=;
	b=sne0KqHq0rJXX7LDtvqbXYhWk908GRUoHKXnBuXPKDEgCTehK5mPq57YZVKZFjm1kS7P7C
	lDR/X5aM9YzvcXfJnFX6zBwI8ia5Kf3T6jRtQB7SWql3inckZBrY8m1BmiFjRmcovJYw0J
	WJrEBqd+q1m43h9aur6Q49LeuppYeLA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0496213398;
	Fri, 10 Nov 2023 09:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id PDtvOnXyTWUQPAAAMHmgww
	(envelope-from <mhocko@suse.com>); Fri, 10 Nov 2023 09:05:57 +0000
Date: Fri, 10 Nov 2023 10:05:57 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	ying.huang@intel.com, akpm@linux-foundation.org, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZU3ydS1Puv2OHgiE@tiehlicka>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <ZUyuL9_8PPiEflnS@tiehlicka>
 <ZU0J+RU1fg8peGJH@memverge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU0J+RU1fg8peGJH@memverge.com>

On Thu 09-11-23 11:34:01, Gregory Price wrote:
[...]
> Anyway, summarizing:  After a bit of reading, this does seem to map
> better to the "accounting consumption" subsystem than the "constrain"
> subsystem. However, if you think it's better suited for cpuset, I'm
> happy to push in that direction.

Maybe others see it differently but I stick with my previous position.
Memcg is not a great fit for reasons already mentioned - most notably
that the controller doesn't control the allocation but accounting what
has been already allocated. Cpusets on the other hand constrains the
allocations and that is exactly what you want to achieve. 
-- 
Michal Hocko
SUSE Labs

