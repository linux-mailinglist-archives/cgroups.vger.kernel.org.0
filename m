Return-Path: <cgroups+bounces-272-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C75047E6740
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 11:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF89F1C209EA
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3813AEB;
	Thu,  9 Nov 2023 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UElFh/9i"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D8913ADD;
	Thu,  9 Nov 2023 10:02:25 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2693E2D65;
	Thu,  9 Nov 2023 02:02:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B225921981;
	Thu,  9 Nov 2023 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699524143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHwA8ZjuKs5PsD64751HJy5aT/pjtH4Nv0BUUWN4lQY=;
	b=UElFh/9iV0/RSdMRUc5MEEhCKXNAelQdQYVt8/v22jXg6gDCngN5J/EL2liPDkXGIfdrBY
	LNAKiIgMv2OuKlTJcmLQy2YF+xbKlXK3DV+a+zCJQVdBis8fmgTrD7WMN1UzOP7tXFPvAv
	tBLNXSzFZzDP5PzwfX1C4SqSD1y/xUA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98EBA138E5;
	Thu,  9 Nov 2023 10:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id gL9LJS+uTGVVZgAAMHmgww
	(envelope-from <mhocko@suse.com>); Thu, 09 Nov 2023 10:02:23 +0000
Date: Thu, 9 Nov 2023 11:02:23 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, ying.huang@intel.com,
	akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, corbet@lwn.net, roman.gushchin@linux.dev,
	shakeelb@google.com, muchun.song@linux.dev,
	Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZUyuL9_8PPiEflnS@tiehlicka>
References: <20231109002517.106829-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109002517.106829-1-gregory.price@memverge.com>

On Wed 08-11-23 19:25:14, Gregory Price wrote:
> This patchset implements weighted interleave and adds a new cgroup
> sysfs entry: cgroup/memory.interleave_weights (excluded from root).

Why have you chosen memory controler rather than cpuset controller?
TBH I do not think memcg is the best fit because traditionally memcg
accounts consumption rather than memory placement. This means that the
memory is already allocated when it is charged for a memcg. On the other
hand cpuset controller is the one to control the allocation placement so
it would seem a better fit.
-- 
Michal Hocko
SUSE Labs

