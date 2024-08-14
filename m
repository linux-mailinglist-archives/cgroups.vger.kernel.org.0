Return-Path: <cgroups+bounces-4274-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D79524F6
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 23:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6401C21CE4
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 21:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1504D1C8232;
	Wed, 14 Aug 2024 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0y8VBtic"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14F7346D;
	Wed, 14 Aug 2024 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672315; cv=none; b=A/3+/rg65NQdKJ9SC6mat6l5QllisMcRt7eQt1S1uwb7ZmwoOrDY41kt2qeQiliVtl4xvgYu/s6bm1ohL/PwtmkKFVnu7mD4a4OTVV5r4vJeOQ82VEy4eGj7OcbDRFjbAD3Jeh+h4uQmyGDsLFXQr0GnfEujmvToFNp6ioDelAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672315; c=relaxed/simple;
	bh=dI01er8IFqXD5BvIIMx9CMLT0DoCZp+kNEXLxRPDkoc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CTZ9dZjV8Z402rUbBzEpROlAkowIixuuK/gcywl/zCyWh+mwJgOiAAuWu+nMQZeKyVyLnN/OjsaOkwFVJmv/SinTfDrvvgKAy7aPmmEuycD3XlrOW/K10kFMikCT+2AqlGUHBZ44c2VkcGERZZ8dRTX4NvWb/xAwqFjURLHvjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0y8VBtic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2008C116B1;
	Wed, 14 Aug 2024 21:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723672315;
	bh=dI01er8IFqXD5BvIIMx9CMLT0DoCZp+kNEXLxRPDkoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0y8VBticqDxqdRo/0oSBNhmj4OrRb4zsNA/YMJo1tc2mdzgAWZ43IynMIyFTcB1Oo
	 /hK5xY0L+T7E5mQE5hLYC220TEl0SX7QOK1ATnWpicPbsW9WyuwEBDfhDfAPns01LN
	 mUZ+/EvLfyTwk6eiIc5p1VaCbWhA3kU1x1F+e4NY=
Date: Wed, 14 Aug 2024 14:51:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 3/4] memcg: initiate deprecation of oom_control
Message-Id: <20240814145154.a115a1642137b71df0650cae@linux-foundation.org>
In-Reply-To: <CABdmKX2HvW3qZ9zrTq0Gz6q0Gg7_XubVY22o3GJoTOhQg=V+8Q@mail.gmail.com>
References: <20240814202825.2694077-1-shakeel.butt@linux.dev>
	<20240814202825.2694077-4-shakeel.butt@linux.dev>
	<CABdmKX2HvW3qZ9zrTq0Gz6q0Gg7_XubVY22o3GJoTOhQg=V+8Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 14:00:03 -0700 "T.J. Mercier" <tjmercier@google.com> wrote:

> > --- a/mm/memcontrol-v1.c
> > +++ b/mm/memcontrol-v1.c
> > @@ -1907,6 +1907,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
> >                 event->register_event = mem_cgroup_usage_register_event;
> >                 event->unregister_event = mem_cgroup_usage_unregister_event;
> >         } else if (!strcmp(name, "memory.oom_control")) {
> > +               pr_warn_once("oom_control is deprecated and will be removed. "
> > +                            "Please report your usecase to linux-mm-@kvack.org"
> > +                            " if you depend on this functionality. \n";
> 
> Missing close paren?

err yes, thanks.

V2, please ;)

