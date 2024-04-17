Return-Path: <cgroups+bounces-2563-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0613B8A8318
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 14:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCD01F24B48
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 12:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CA413D614;
	Wed, 17 Apr 2024 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VAcYSu3S";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kZtRR5ba"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161613D2BD;
	Wed, 17 Apr 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356694; cv=none; b=PNFQMGgZjqidW6yxj3ctjvjtNKNDOET3D02YvR+tqyOeNVauZJnbrISS3p67/o7Cv04xRQf4HbFDO7iZ5f4h3uYMfZI2IlixCMWobdlP3G9OkuuZAnaI/+4otNMWQSz2EXr1N5H9E+22/PBEwiJ4h+aZVAtyxptPvA58MukXYkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356694; c=relaxed/simple;
	bh=z4Gu5qWkv/b/cx2hcRaqKXSN/jIg5ez6d7+8R7hTHOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Als+h0FLr6W74jDdgVO19nFAiYc5OHWof+6NdEwHmjN0WSzZEbMWxCRr/Vn16bXzGtzGz/9rqRO++D5OvzxqZlcZ/bifKDb1A18WvVravQxGH3VPD6w9+DMZA8OfVjbEgB6gkMi4LdY1c67wB6cN1tZEwdbarThf74YSu5XUXaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VAcYSu3S; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kZtRR5ba; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7956C33C1A;
	Wed, 17 Apr 2024 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713356690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n7gZgeMX+J5HSmuMB3qC2Ah2TcNIJGZlP9Si3K/N6/o=;
	b=VAcYSu3Sx7uIbxCWr4HgSjnU7tCl+7FrsmI2lO/cVDmcBJJwOuClb9ZNzmf1ZN6ch9TsAD
	dUX8vt+XTpb4pUUDIPx3BGcM5V9H0ZwMkhzGie2aQv5LyQTTLp9JnuTEJOVl5pbWuuHH31
	qgsEdEipZZDNT8KEygfx4AAloz9EhZA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713356689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n7gZgeMX+J5HSmuMB3qC2Ah2TcNIJGZlP9Si3K/N6/o=;
	b=kZtRR5baUVfIrI5lz/QyQku+8P3TIY7z8OHgtV6v8sqxES0onFTnFSfn/AG93o9NwWY2f5
	/hk00JZ/VBXJKXZjqlGFv9v6xj22GD5ILB9JNUX99qn3t9ORao0niYn4JoxSgNJpcD+0xN
	S/8yABdzfBXZJUdQrZOjniMXX5Qn9wM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 524BE1384C;
	Wed, 17 Apr 2024 12:24:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l6CQEZG/H2b4GwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 17 Apr 2024 12:24:49 +0000
Date: Wed, 17 Apr 2024 14:24:44 +0200
From: Michal Hocko <mhocko@suse.com>
To: lipeifeng@oppo.com
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix the comment error of memcontrol.h
Message-ID: <Zh-_jOtSyv6DoETP@tiehlicka>
References: <20240417121645.25355-1-lipeifeng@oppo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417121645.25355-1-lipeifeng@oppo.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.16 / 50.00];
	BAYES_HAM(-2.36)[97.05%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oppo.com:email]
X-Spam-Score: -3.16
X-Spam-Flag: NO

On Wed 17-04-24 20:16:45, lipeifeng@oppo.com wrote:
> From: Peifeng Li <lipeifeng@oppo.com>
> 
> Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
> ---
>  include/linux/memcontrol.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 394fd0a887ae..07d08be706bf 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1679,7 +1679,7 @@ static inline bool folio_matches_lruvec(struct folio *folio,
>  	       lruvec_memcg(lruvec) == folio_memcg(folio);
>  }
>  
> -/* Don't lock again iff page's lruvec locked */
> +/* Don't lock again if page's lruvec locked */

Not a typo. iff stands for if and only if

-- 
Michal Hocko
SUSE Labs

