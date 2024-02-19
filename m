Return-Path: <cgroups+bounces-1701-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5FB85AC05
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 20:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D471F22E22
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAF350A6D;
	Mon, 19 Feb 2024 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sVfwVoaD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sVfwVoaD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711851C2A;
	Mon, 19 Feb 2024 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371226; cv=none; b=ngPgFA7Oo3P/xwB7p9idd7PzqI6fsedyVefmT7n6l53J/H7v761AG+7O7BSLvopxSfUYc/Fyp30xNK0SXP4IR5zh7eI0mJ6kukmMtf9agb+wJJQVnu+PSb067aeoMOst4BRNFEUQObTz50zCz8I7PeRDyOmWDzTf0usVKdvKZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371226; c=relaxed/simple;
	bh=15qqgc3nC64cmRS12BFFHTnozV/EM0f47w86rm+TtAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIdzCq/9GZ9jlIjv6qyHrABBc1vOSD1qHx0dRA1T9KJ49LkOCtGemMveUURQtW1bMXWvGWU348H3n7oy68y6c9rmHBCLt/wPP8WAbHNulE2Qa8zgbC/HUox0TXuQ/lMHmdGh0yIYCTXZhR607FdSy4TJFh8C6PFcKcPB3rNjfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sVfwVoaD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sVfwVoaD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C47D91F820;
	Mon, 19 Feb 2024 19:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708371222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEEchMU2eWyAGkbixbgw2dnBZQH6T3ohOnMXKOjuWAY=;
	b=sVfwVoaDFY6zDWy8PQxJqgtEqxnI3r4JWQahOXgpiHmuGxsXU6I0Mn30+p9wPp0jtiDeIc
	zblFDCKuDHIBHp4VvSeOXKyNtFXTLQVirU7WIUg7oDGlxA77tnNy/WEFWQs8SvZ0AUdJL2
	0a8ozu13LwlWxiBR4dr7Vu5ZRUFtACI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708371222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEEchMU2eWyAGkbixbgw2dnBZQH6T3ohOnMXKOjuWAY=;
	b=sVfwVoaDFY6zDWy8PQxJqgtEqxnI3r4JWQahOXgpiHmuGxsXU6I0Mn30+p9wPp0jtiDeIc
	zblFDCKuDHIBHp4VvSeOXKyNtFXTLQVirU7WIUg7oDGlxA77tnNy/WEFWQs8SvZ0AUdJL2
	0a8ozu13LwlWxiBR4dr7Vu5ZRUFtACI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A678913647;
	Mon, 19 Feb 2024 19:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2W6jJRat02UyLAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 19 Feb 2024 19:33:42 +0000
Date: Mon, 19 Feb 2024 20:33:38 +0100
From: Michal Hocko <mhocko@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com,
	yuzhao@google.com, mkoutny@suse.com,
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: memcg: Use larger batches for proactive reclaim
Message-ID: <ZdOtEgwuwDTtVw3L@tiehlicka>
References: <20240206175251.3364296-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206175251.3364296-1-tjmercier@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 06-02-24 17:52:50, T.J. Mercier wrote:
> Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
> reclaim") we passed the number of pages for the reclaim request directly
> to try_to_free_mem_cgroup_pages, which could lead to significant
> overreclaim. After 0388536ac291 the number of pages was limited to a
> maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overreclaim.
> However such a small batch size caused a regression in reclaim
> performance due to many more reclaim start/stop cycles inside
> memory_reclaim. The restart cost is amortized over more pages with
> larger batch sizes, and becomes a significant component of the runtime
> if the batch size is too small.
> 
> Reclaim tries to balance nr_to_reclaim fidelity with fairness across
> nodes and cgroups over which the pages are spread. As such, the bigger
> the request, the bigger the absolute overreclaim error. Historic
> in-kernel users of reclaim have used fixed, small sized requests to
> approach an appropriate reclaim rate over time. When we reclaim a user
> request of arbitrary size, use decaying batch sizes to manage error while
> maintaining reasonable throughput.
> 
> MGLRU enabled - memcg LRU used
> root - full reclaim       pages/sec   time (sec)
> pre-0388536ac291      :    68047        10.46
> post-0388536ac291     :    13742        inf
> (reclaim-reclaimed)/4 :    67352        10.51
> 
> MGLRU enabled - memcg LRU not used
> /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> pre-0388536ac291      :    258822       1.12            107.8
> post-0388536ac291     :    105174       2.49            3.5
> (reclaim-reclaimed)/4 :    233396       1.12            -7.4
> 
> MGLRU enabled - memcg LRU not used
> /uid_0 - full reclaim     pages/sec   time (sec)
> pre-0388536ac291      :    72334        7.09
> post-0388536ac291     :    38105        14.45
> (reclaim-reclaimed)/4 :    72914        6.96
> 
> Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive reclaim")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Sorry, I've missed this version
-- 
Michal Hocko
SUSE Labs

