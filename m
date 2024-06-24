Return-Path: <cgroups+bounces-3308-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FB4915501
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 19:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28786B250C4
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66219F468;
	Mon, 24 Jun 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7rUUkMg"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8F19E83E
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248741; cv=none; b=i9Gs9Z/Vyw0AQ9s9fmbmFwXpIwDM+bFD89Uzt9UV0b26X6fsxvs54n5CW9jv0anWIx++3oe3RDOEC+rYfkGPIU9uyd7C6HCMf6qInq5dOR7mMAdboA+hQhUncJlLuXA+c5MuAndgtGpB0Cnle7qPt+MQgJx8LbLhL3EefF6AN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248741; c=relaxed/simple;
	bh=0LBiPH3Y7aq/3vm3Rkxz0WXxU3vDkOw7NDED++iEpo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUA7SL8afSINXei9/LwnjHNwj/8S23u+S+cwyal3hROIRalsfGjSorfnMh7wMtHu2waChsVFv5fvC7oa7mIDJLbcLNqkUb8PN3JPfM0f3CINRxeTDxtsIKDTL7MHPrQ57uur5RqPKrHlJ/cL3krngb3IBTzwP0dzA42drCWmB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7rUUkMg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719248739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LBiPH3Y7aq/3vm3Rkxz0WXxU3vDkOw7NDED++iEpo4=;
	b=R7rUUkMg3e5MtN7IbNES7W/TJ364q6KheJKd8tokVHtqdfL0Yt4ZyoB1AmVfsoSjpcrC0d
	reWmMV76x/+QvzHgbbC/JSnY/juCWDBo9Gt5uAhtWs09u16s4UY9486T7EYt0WhtSDoy++
	+8f3PskouAH+0qf0FzzzOPp3SqI37Lw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-j72fES3LPGiQGvOqEetYdg-1; Mon,
 24 Jun 2024 13:05:36 -0400
X-MC-Unique: j72fES3LPGiQGvOqEetYdg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C5C61955EF2;
	Mon, 24 Jun 2024 17:05:32 +0000 (UTC)
Received: from [10.22.17.135] (unknown [10.22.17.135])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F193B1956048;
	Mon, 24 Jun 2024 17:05:29 +0000 (UTC)
Message-ID: <dc27e80f-8471-4b31-90f0-5105236bea8d@redhat.com>
Date: Mon, 24 Jun 2024 13:05:29 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: Add a new sysctl parameter for automatically
 setting memory.high
To: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 Alex Kalenyuk <akalenyu@redhat.com>, Peter Hunt <pehunt@redhat.com>,
 linux-doc@vger.kernel.org
References: <20240623204514.1032662-1-longman@redhat.com>
 <77d4299e-e1ee-4471-9b53-90957daa984d@redhat.com>
 <ZnmO8izZPwYfiaRz@castle.lan>
 <d97e2e8f-0abc-49a7-bead-0501c1226040@redhat.com>
 <Znmi8lfORdPoI061@tiehlicka>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Znmi8lfORdPoI061@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 6/24/24 12:46, Michal Hocko wrote:
> On Mon 24-06-24 12:33:27, Waiman Long wrote:
>> I also trace back the OOM problem to commit 14aa8b2d5c2e ("mm/mglru: don't
>> sync disk for each aging cycle") in the MGLRU code. So setting memory.high
>> automatically is one way to avoid premature OOM. That is the motivation
>> behind this patch.
> Please report this.

OK, will do.

Cheers,
Longman


