Return-Path: <cgroups+bounces-3449-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA7891BE3F
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 14:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2A0283DB5
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3FB158218;
	Fri, 28 Jun 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVHi2VzL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3271865A;
	Fri, 28 Jun 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576818; cv=none; b=JBcEih7tH+m7Jh+b0kcyRZxVxF7FjHOLCeqrS0nl44JbXgnqdTjNeDG25T/CFSAJDIeCXxFc0esqeU0eHmEsZKSTZStvddDoHHb+abAKtp//+gasjJzw+AmSXrziS5Ws+ZQs7d1Gl/i3IwmXUbZhI79sS4X7xZ/aucUKcqV4KMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576818; c=relaxed/simple;
	bh=ewO2QXATiqIezNRUtR6i4nD/oZNLXvq3+JsgCScLqrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qH28jhK+Pj0ycuKZ5TtLDgSO+22zbeiKJps//khPacyDvuB0sn6Md9Ke5N7bgxBAqA7rxtO4Fxb9Ce6P0HOCgm90Opdy+9pYDjSG/fTNtVkSRW/OqYW5GjoMqyqaGJY/emnw+8ahQwflIBqCQa5ip80D1nSlDxYgFrGX+2yDTsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVHi2VzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73200C2BBFC;
	Fri, 28 Jun 2024 12:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719576818;
	bh=ewO2QXATiqIezNRUtR6i4nD/oZNLXvq3+JsgCScLqrw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qVHi2VzLA6QfYwM501xLUSpEOxpj/5LebBxcKl1K5XI6jrJPXefkLik8OIUYt1mrr
	 wIgEkJsZsScISMwn0QGJVEqrU0cXxbREPhCPos3jfks8sjKXSymeICTvZEsD82sMKQ
	 QvKOqeu1Kw0Kkyv5Cyk8Wdt20w/xN+xEGDZX0WuPWRfv4UX2rWl+Ex3GhSkdpkR4gz
	 lxd9hOurLxuQ9JiAzRvIrpwBzCZSx8fRL0miWjVZDgGmIQHpgSvhJW1NitFJeb3/Mz
	 vnZU/mUFwXVJN93mvSQggkbBQWDMjDg2jfgJxNSngUJS6BkQ673f2GOhdiaThcHRC2
	 fT+PCPnu9qqmA==
Message-ID: <b637705e-6a7c-4329-9109-50e9f568e64c@kernel.org>
Date: Fri, 28 Jun 2024 14:13:34 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] cgroup/rstat: Helper functions for locking expose
 trylock
To: Waiman Long <longman@redhat.com>, tj@kernel.org, cgroups@vger.kernel.org,
 yosryahmed@google.com, shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <08062501-f3fb-4e4d-b72c-f1b0f964640f@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <08062501-f3fb-4e4d-b72c-f1b0f964640f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/06/2024 00.22, Waiman Long wrote:
> 
> On 6/27/24 17:18, Jesper Dangaard Brouer wrote:
[...]
>>
> Will it be cleaner to add a "bool *flushed" output parameter to 
> __cgroup_rstat_lock() so that the caller can respond differently whether 
> the flushed flag is set or not? In that way, you don't need to expose a 
> separate trylock() API. Also your commit log is empty.
> 

Dropping this API in V5 anyway.
But I do think it is more natural to follow the 'trylock' API as this is
something that people have seen before.

--Jesper

