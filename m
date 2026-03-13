Return-Path: <cgroups+bounces-14817-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCaZARZAtGlljgAAu9opvQ
	(envelope-from <cgroups+bounces-14817-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 17:49:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E0287664
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D79E3025E37
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE15D3C5DDE;
	Fri, 13 Mar 2026 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="FkSE+ibx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91212153D8
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420561; cv=none; b=lBsS7elTDs+dYniUUWm1fXoNOvoqSF3jCoVKry98UwA1rUtQZvW8EcjEz3BDYWCMc2HFfPLH1SwOL5ujwdD2o16UtCumE4zRUvzT2di1/WmKpHczOwd926BqB/UbDQfiBX9LS3f8H5YZQE09j4WLZuRzUWMnabkIXFk/7UhdIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420561; c=relaxed/simple;
	bh=Fvu4rFLx4/jHcluR8mvL4PiOo3RupiVNDxoPUUpdiNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFtWIacE6l/HUO1Z+GssJJgYwfNC9LddRj93EY/d5rLleWLjvZa/eJC8HaqXcov7c7y3ClzqgPdf7Tq29ss3SRvhpn09KKbVagSQaEuRBI+e/96zfFtjpROE0kciYm16/c3lNJWRdPn63+pPC99N9Xr7l0EBNgPXMMny7RTzGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=FkSE+ibx; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899fb2b94c1so31611246d6.3
        for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1773420558; x=1774025358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5OoZ6jFB25D0x8NU02gRfdPPo1/nMY4T6UovZLQVRg8=;
        b=FkSE+ibx44xTjdz6Klzc/l+h2PnRPwi5Qrxm3vIBXdXu+CHd/vI+fwgnm/QOi6VCoi
         6qG+N5JtgDyLwQg8L9UoSXytJig1Q5Y8SfjWLVC58QPVP+piY0AO82l760vtqdOFsHyG
         tZINB5JPFL9O4ZiVGUiP4RR85OuLKoLkLompk/57Xr+gzMatMxlTqyRI10RiOyWfNJIJ
         6rPaeJRz92fkFv9iDKp3m/mXsOJo8u7I6Lr3nvUGQc9kW8kF6PqWLn75lRlfCC/cI3+4
         P5ZpDDjjqW1+W3Vii8O455VnNpigcXXoSzI99nRmU8TvObTIOsgtClyOPfPyjuZDvVgC
         owVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773420558; x=1774025358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OoZ6jFB25D0x8NU02gRfdPPo1/nMY4T6UovZLQVRg8=;
        b=jMFZPec7lm76HAHI0Iutlw3X35Td2tdpNdHMHxSnnZXnyLz5dpBvoz7CNp+5leFzpF
         PeEOdBfJ8AIdRHgI5WHW8UepWi2zRNqIwA6zuDMJHuMSUsP/MgD9TGBhkaDJqJqXmVi3
         elvx04PPQn1D3Li+6kEQ8DmUoSco08PDbZXDyM9l/rsCzyXCQSasg/3vRz5aGSKelfMO
         pYCxJO3QQ52y89Sk4dd14r2WywO8EtT69A1bckrBPdeY+LoY0Jfy6jyENqf+T3LIsgPu
         4SS1UBfd8LWvpSjXrjCIk4njdXp0pPXlMiZfG3EalRq6At5GBArv99beRsmARVMm5+R+
         ZKBg==
X-Forwarded-Encrypted: i=1; AJvYcCUbJW247fff43APTU4Ug3kRclx2Lt5gJjwQPHshVktktNbog5Z9bWdLBoX4W/0k68Ke30sXelQI@vger.kernel.org
X-Gm-Message-State: AOJu0YzIi+exfdFdwWPWBBBkimMpe0hJ2VFcK43IG4niN93SnbNhYeYi
	1Y9LR+QpHZqZzBn3y2KAS1371ONABHYf8Y7xT1n8seFtKeV+8rPOrAW4AQNywkw0W0c=
X-Gm-Gg: ATEYQzxgCiXT0CnkXkBsF+98+MauJg+p9hWW2YeeDT3d7DkHR11XjXKt375jGC+xmiu
	TGj2Ted2K9AP97853E9D+zXDsoBp4KZP0sNk+1qqNxNj8VccedeebTs607ulGYzdW+RkbD8K6vW
	L+FXUEmIB7/bKlaK7y34OYGM47myzcRB2qdO0gkTjhKoMfNJ44KMDo9+20jVBgNLdFp6YXzOgmA
	zOHmvRmKzgBS4hhb0fJSgYLAju6klDPNEqG+ksqjrlGg8YdXUoFzs+h2YFysIzSQqt6p45UdiiP
	CpMG8mMkpClSBHqBnikZSreWwcbLZeOsmuAhyi4zif13ll3QfxdfGXMhc5UHfSMJ+lJzP4PMxji
	dULAMRWIRA5x+UVD0HvBmiwerlPGJRofZ7nXjshjMfGsPHoYEDCj6IAyuAgCKWXswcJHqeS6sSr
	lTNmKG3LzL5Khevdi1SLbf1g==
X-Received: by 2002:ad4:5c49:0:b0:89a:ff2:b8d3 with SMTP id 6a1803df08f44-89a81f8c6c3mr64520096d6.43.1773420558533;
        Fri, 13 Mar 2026 09:49:18 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bd318fsm58816146d6.8.2026.03.13.09.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:49:17 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:49:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 07/11] mm/zsmalloc, zswap: Handle objcg charging and
 lifetime in zsmalloc
Message-ID: <abRADNpx8vhTMP-d@cmpxchg.org>
References: <abMzKa27khxDLO_D@cmpxchg.org>
 <20260313153434.4074128-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313153434.4074128-1-joshua.hahnjy@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14817-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,chromium.org,linux.dev,gmail.com,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cmpxchg.org:dkim,cmpxchg.org:mid]
X-Rspamd-Queue-Id: A32E0287664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 08:34:33AM -0700, Joshua Hahn wrote:
> > IOW, it's better move that obj_cgroup_get() when you add and store
> > zspage->objcgs[]. If zswap stil has a reference at that point in the
> > series, then it's fine for there to be two separate obj_cgroup_get()
> > as well, with later patches deleting the zswap one when its
> > entry->objcg pointer disappears.
> 
> Sounds good with me. Maybe for the code block above I just move it one
> line up so that it happens before the zspage->objcgs set and
> make it more obvious that it's associated with setting the objcg
> pointer and not with the charge?
> 
> And for the freeing section, putting after we set the pointer to
> NULL could be more obvious?

That makes sense to me!

Thanks

