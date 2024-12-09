Return-Path: <cgroups+bounces-5788-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF7C9E9FF0
	for <lists+cgroups@lfdr.de>; Mon,  9 Dec 2024 21:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB29228281B
	for <lists+cgroups@lfdr.de>; Mon,  9 Dec 2024 20:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873FF1991AA;
	Mon,  9 Dec 2024 20:00:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F513B5B3;
	Mon,  9 Dec 2024 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774452; cv=none; b=Uta8tGis2uJYL/gEiPc5Kb6eQ3kRzblACSl3gzwZb0Wk3PbZfuz4vGRXqe9t8typF3p2pueDb1GAkt+fjnQPpXWq/jnc0iE8bQhkUAmU+SUWAvOn4A882GONUM5NJzEL2S6zcw5oShyZKSu47zSXrorL+c7myrkMNQI6oWd5tLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774452; c=relaxed/simple;
	bh=6x3BJGehzZL6Q28pJXlaF85I4QG/1kQD1joAJW9ieuc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8sN0T5+fnFIU1/eXHEUeHVIcrdl63tpUglyefQ8bQQk8fXlP7OM5GbR/o5/K9KaFu29Bzlf6YfvsxKnC8VQwSKiquN2J4eUei1KybKktdyqB0Iksq8OPswVtfqy9QOEa881sWfWvCuk0DkjITxKliQM/F3yd++Ocd0pk2Gk+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tKjvM-000000002dV-3bRj;
	Mon, 09 Dec 2024 15:00:08 -0500
Message-ID: <0623a91b45b8ac96c9b7b910ef3a916f2f924050.camel@surriel.com>
Subject: Re: [PATCH] mm: allow exiting processes to exceed the memory.max
 limit
From: Rik van Riel <riel@surriel.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Roman Gushchin	
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun
 Song	 <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org
Date: Mon, 09 Dec 2024 15:00:08 -0500
In-Reply-To: <Z1cyExTkg3OoaJy5@tiehlicka>
References: <20241209124233.3543f237@fangorn> <Z1cyExTkg3OoaJy5@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Mon, 2024-12-09 at 19:08 +0100, Michal Hocko wrote:
> On Mon 09-12-24 12:42:33, Rik van Riel wrote:
> > It is possible for programs to get stuck in exit, when their
> > memcg is at or above the memory.max limit, and things like
> > the do_futex() call from mm_release() need to page memory in.
> >=20
> > This can hang forever, but it really doesn't have to.
>=20
> Are you sure this is really happening?

It turns out it wasn't really forever.

After about a day the zombie task I was bpftracing,
to figure out exactly what was going wrong, finally
succeeded in exiting.

I got as far as seeing try_to_free_mem_cgroup_pages return 0
many, times in a row, looping in try_charge_memcg, which
occasionally returned -ENOMEM to the caller, who then retried
several times.

Each invocation of try_to_free_mem_cgroup_pages also saw
a large number of unsuccessful calls to shrink_folio_list.

It looks like what might be happening instead is that
faultin_page() returns 0 after getting back VM_FAULT_OOM
from handle_mm_fault, causing __get_user_pages() to loop.

Let me send a patch to fix that, instead!

--=20
All Rights Reversed.

