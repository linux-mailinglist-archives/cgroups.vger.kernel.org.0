Return-Path: <cgroups+bounces-2138-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCA28864E1
	for <lists+cgroups@lfdr.de>; Fri, 22 Mar 2024 02:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F501B21C4F
	for <lists+cgroups@lfdr.de>; Fri, 22 Mar 2024 01:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B947138C;
	Fri, 22 Mar 2024 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gf50hvI0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D756E138E
	for <cgroups@vger.kernel.org>; Fri, 22 Mar 2024 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711071714; cv=none; b=H7w7HzG2W6mQhbIJ5auVpc417B0YtXRucsKQnP5g68jMtk7rNO9av0kH39k6jcu3hfFKqeTTHOKhBul31TkgRBH8JKuDtrOEyvoDR7qZV6MSlaJ5qHqcKXziIK6ASVLluAdAwyIeQgJvqXvVTCzjpNlwZjU0PAVQRBx4uV1djEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711071714; c=relaxed/simple;
	bh=pN5i46unjVwDCRCkxuPck5jwbib3bYB0AKbCYsK5LZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Euaw10DGZB3GgF0fbX5BT8eYIglW3vECYYuAMJGKlDs/eO5EXAcE45sM4TM+aoXOh8bnsusna+46EBmzgFeh4/qOuusrWwCk6DTE27e8IGjHhEa/5OxZRnczHBMtiqn4Jd4vNCs+zA5P8Tc7vNiOI1i0EnkjRpRmZ6l7fbobaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gf50hvI0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711071711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVgf6o2s5ooozkoCSyIQzdNUcgVIYJXIpauyyne9ngU=;
	b=Gf50hvI0D9X2zn2CHpUsHjwgmKNcKJmpCkOcJcsAcSKBwy9HZk8++iMywSGgxe8ZfmtaPd
	a/fYr1sRCF5sHCDP9lPydVpNaPkoSMgNY3j30VxwYYm25v6xavtnj8/T8nNM+Y/aDCjlG6
	zlzxO0eifyH+pcrEgdf22fZ5IFS3nwk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-AjXrSN2SNmiQ-nsjLihx1Q-1; Thu,
 21 Mar 2024 21:41:48 -0400
X-MC-Unique: AjXrSN2SNmiQ-nsjLihx1Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 097A11C02D35;
	Fri, 22 Mar 2024 01:41:48 +0000 (UTC)
Received: from [10.22.32.107] (unknown [10.22.32.107])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CC81D492BC9;
	Fri, 22 Mar 2024 01:41:47 +0000 (UTC)
Message-ID: <7b932090-5513-478e-90ff-62832d8acefb@redhat.com>
Date: Thu, 21 Mar 2024 21:41:43 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC]: Make cpuset.cpus.effective independent of cpuset.cpus
Content-Language: en-US
To: Petr Malat <oss@malat.biz>, cgroups@vger.kernel.org
Cc: tj@kernel.org
References: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 3/21/24 17:33, Petr Malat wrote:
> Hi!
> I have tried to use the new remote cgroup feature and I find the
> interface unfriendly - requiring cpuset.cpus.exclusive to be a subset
> of cpuset.cpus requires the program, which wants to isolate a CPU for
> some RT activity, to know what CPUs all ancestor cgroups want to use.
>
> For example consider cgroup hierarchy c1/c2/c3 where my program is
> running and wants to isolate CPU N, so
>   - It creates new c1/c2/c3/rt cgroup
>   - It adds N to cpuset.cpus.exclusive of rt, c3 and c2 cgroup
>     (cpuset.cpus.exclusive |= N)
>   - Now it should do the same with cpuset.cpus, but that's not possible
>     if ancestors cpuset.cpus is empty, which is common configuration and
>     there is no good way how to set it in that case.
>
> My proposal is to
>   - Not require cpuset.cpus.exclusive to be a subset of cpuset.cpus
>   - Create remote cgroup if cpuset.cpus is empty and local cgroup if it's
>     set, to give the user explicit control on what cgroup is created.

I think we can make cpuset.cpus.exclusive independent of cpuset.cpus as 
a separate hierarchy to make creation of remote partitions easier. I 
need some more time to think through it. I don't think your test patch 
is enough for making this change. BTW, you confuse cpuset.cpus.exclusive 
with cpuset.cpus.effective which are two completely different things.

Cheers,
Longman


