Return-Path: <cgroups+bounces-2792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7E8BD0AE
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 16:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A862A1F22006
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2D1153584;
	Mon,  6 May 2024 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h+nh5+x9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h+nh5+x9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4C44C81;
	Mon,  6 May 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006982; cv=none; b=jIFAdCSXdOSEZgFmfgypeG6cnEfM8GSuYHug8+i30YVo4HEXOFc5yJzprG59KRC+5bKpQe30g3IIQ0NTujIgCEe40xFMycJh3P8RK2QZ2b6VYbk168Op0dHjSfKI4Z/BEX4fNlzzAu0vIInBn4h4Tzezn4xlUHMfbj4VxX3LG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006982; c=relaxed/simple;
	bh=YaT9TitsE4+neqbGRaiWJj3h0o7SRpwaRAiRg6Sesg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdhCksdo2xov0gS5wVLdhLdX2bancXIGQoHju4FcYqyMxU1JDvNxKAb2erRG/Mtc/3DRJk4+S9yNPsJprlVG3bVaxD9+TPPLHlvn14W8C+T00Fah/P3BVMrw+hzKJTdFrx6G/9Y6J5Gas4UGmmEsG80RgBhTIccgSp9i+XEwNSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h+nh5+x9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=h+nh5+x9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AF245FEBF;
	Mon,  6 May 2024 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715006978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SjI8VAl0W+J1vcR3bFCMW1ShLhq8ix+ki0A3tbAkyc=;
	b=h+nh5+x9CTVXkLIHwAMBIkfOqiSzV8va338K+8d2goT4GNJXbBH/PXF7/vYGaYV3yRAeDl
	daQ6gOABZeqq9pqH50K4zoX57RIJkoEJgIBLfMooRc8osmDOjRK7k0qWCpLXbFzJlWa8+M
	50oJXSS6z2v3NnSbosVXVRtBbeI0oMo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715006978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SjI8VAl0W+J1vcR3bFCMW1ShLhq8ix+ki0A3tbAkyc=;
	b=h+nh5+x9CTVXkLIHwAMBIkfOqiSzV8va338K+8d2goT4GNJXbBH/PXF7/vYGaYV3yRAeDl
	daQ6gOABZeqq9pqH50K4zoX57RIJkoEJgIBLfMooRc8osmDOjRK7k0qWCpLXbFzJlWa8+M
	50oJXSS6z2v3NnSbosVXVRtBbeI0oMo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5973413A32;
	Mon,  6 May 2024 14:49:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fMt6EwLuOGYldwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 06 May 2024 14:49:38 +0000
Date: Mon, 6 May 2024 16:49:33 +0200
From: Michal Hocko <mhocko@suse.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: use meaningful error code for return
 value
Message-ID: <Zjjt_Tv4ZxCCcpcG@tiehlicka>
References: <20240506133643.1124102-1-xiujianfeng@huawei.com>
 <Zjjg60ZW-d7r-DS9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjjg60ZW-d7r-DS9@casper.infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -3.79
X-Spam-Level: 
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]

On Mon 06-05-24 14:53:47, Matthew Wilcox wrote:
> On Mon, May 06, 2024 at 01:36:43PM +0000, Xiu Jianfeng wrote:
> > alloc_mem_cgroup_per_node_info() returns 1 if failed, use -ENOMEM
> > instead, which is more meaningful.
> 
> This should probably be changed to return true/false instead of
> an int.

Agreed. Or change the only caller to consume the error. Changing to bool
seems like the easiest way.

-- 
Michal Hocko
SUSE Labs

