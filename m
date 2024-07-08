Return-Path: <cgroups+bounces-3574-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1313092A9B5
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 21:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446231C219FA
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504214D444;
	Mon,  8 Jul 2024 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1wA5Zbx"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931014BF9B
	for <cgroups@vger.kernel.org>; Mon,  8 Jul 2024 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466298; cv=none; b=vE1omzHx8BDuA3Iz6S3b1GhBo9arYrLPztDWK+E6FAczPakYBwD2PvSu6sieUJgLTQ22Kj+Uq2AyVob103St8DOf7r3Y4GOYO2WysSa5PGXPeJ4PZUMlc+C8unlVr2j54nxhFaCuQK7duw4Peir8BFayJRfuZDWJpqcBxEpIveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466298; c=relaxed/simple;
	bh=fwrRPjERoSZ6CqkMuWcjL2cBbBr4VQ99K9lE4QdPeSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKdAF9QwCIGTnNRPP28flSgHOrDcHJR5pskYPiItGdl8gV6bmJ3/y4TGpsqca4/NteR3UBWdPEcOLqApOr644U1ctMcXqljmzwf9SUhYQCg5timQj5/v99rXIclApI6ISRlGdz07O51LwBJxegUL+jcPzoXBL5pX20alQEJiv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1wA5Zbx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720466295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YuqhwnMC2FTvXqhKkRb1IH9ySMQsan/iAwXs09cQsW4=;
	b=Y1wA5ZbxYIB327sJRbrDNwY+LriBwURbR03ZXAUU9jwwmiqTZZ9fmnb377oCJxPu4B6eNf
	Ywu74vOH0/pkg+/pnAxMw2tKscQ28LLcBOzwN1dMDJV8bdxlcmmufnyjNOqgRVKcX0PYXO
	700aoX38cQ3d1ZBi94uYVwtctZNz8eY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-X8HmxJlKMA6A2hiIvEL87Q-1; Mon,
 08 Jul 2024 15:18:10 -0400
X-MC-Unique: X8HmxJlKMA6A2hiIvEL87Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FA231955DDB;
	Mon,  8 Jul 2024 19:18:08 +0000 (UTC)
Received: from [10.22.33.83] (unknown [10.22.33.83])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14B961955BD4;
	Mon,  8 Jul 2024 19:18:06 +0000 (UTC)
Message-ID: <8527c0db-b3c1-46ba-86b5-6b3a776585b1@redhat.com>
Date: Mon, 8 Jul 2024 15:18:06 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup 1/2] cgroup: Show # of subsystem CSSes in
 /proc/cgroups
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240706005622.2003606-1-longman@redhat.com>
 <Zowzvf2NEOzgXYr3@slm.duckdns.org>
 <b505c15b-8fd2-44f2-8e33-46ae29c2696e@redhat.com>
 <Zow4ZJFa6Kwz4BlO@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zow4ZJFa6Kwz4BlO@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 7/8/24 15:05, Tejun Heo wrote:
> Hello,
>
> On Mon, Jul 08, 2024 at 03:01:39PM -0400, Waiman Long wrote:
>> That information is certainly useful to display to cgroup.stat which
>> currently only shows nr_descendants and nr_dying_descendants. So does
>> "nr_<subsys_name> <cnt>" for each cgroup subsystems look good to you or do
>> you have other suggestion?
> Yeah, something like that. Johannes, what do you think?
OK, will work on that.
>
>> The reason for this patch is because I got a bug report about leaking blkio
>> cgroup due to the information shown in /proc/cgroups. I know you want do
>> deprecate it for cgroup v2. How about adding a iine like "# Deprecated for
>> cgroup v2, use cgroup.stats file for cgroup counts" at the top of
>> /proc/cgroups when cgroup v2 is active?
> I wonder whether that would break some parsers but we can try that and see
> what happens.

I suppose the parser should skip line that begin with #. When testing 
this patch, I realize that systemd does parse /proc/cgroups when in 
cgroup v1 mode and change to it may break the bootup process. This file 
doesn't seem to be parsed at all when in cgroup v2 mode.

Cheers,
Longman


