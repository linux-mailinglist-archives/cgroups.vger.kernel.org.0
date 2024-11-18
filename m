Return-Path: <cgroups+bounces-5620-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CE99D16BF
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 18:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78DBBB242D4
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99CA1BD4E2;
	Mon, 18 Nov 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ji3S5ROg"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE74198A17
	for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949683; cv=none; b=lulo8L3EGkPa3NV9hC0oRbmwifin2Kquub0TzuWGUFmIrvqWGEmPJScqhenU919VBFnI5e39QbPbiCn+lzCzethlPszk3H0kTl8qmgUKFLe7oTGt6X4BItzoeGZQiD1hcyuL2WghCABrXjQe6dccTjU3dD1BN0pcH3hJsZT3h2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949683; c=relaxed/simple;
	bh=/8iy2Yxv8jn8YuzzWY1ivqBayFy4kmiCLetXx9i6t6g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gDG8E8UGQnTFG8BZ9FqU0FK9XXiYMAMJKR4AjdN3TEiVwuK9laSoe58ZvuGGyDA38tkzvw/bcl7YoJRBmwYOscyzKw1+PwikKXucdRz1S8T9iMwJDDsLHhy5BhaL3tssb9OVYmmM6ynKmF1G/YGGF71lpJALmSRjePBWyi6kcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ji3S5ROg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731949680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOy6TWYOIIvmQVw4uDICe421PFT8nzfxjKb662ixvBs=;
	b=Ji3S5ROgBbTnllonfgCeFC6/gsjxXqqaiSJPCL4qPHQ3byir6juP0HNCfn1gvkClEh2TOj
	IZ+lvTJctXAnwXP92kxNCE0fV9lD7iARKc/2UA3iKiLVPVXavQuV+OLoEbg4FuMiKMM9mX
	mzlL0DGs6KTMJ8Nwjq94/ymMWf4txBQ=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-8kT8PlXTNQG9JbUOMuviwg-1; Mon, 18 Nov 2024 12:07:59 -0500
X-MC-Unique: 8kT8PlXTNQG9JbUOMuviwg-1
X-Mimecast-MFC-AGG-ID: 8kT8PlXTNQG9JbUOMuviwg
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7634d8538so12254455ab.0
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 09:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949678; x=1732554478;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOy6TWYOIIvmQVw4uDICe421PFT8nzfxjKb662ixvBs=;
        b=hdqb6T8+IuDVmCjlEfTepUHCKvyDZQL5LZez0RGKupJMG2WF0RHYcIl1LDuGlcuhQe
         DwZPL44jf3Q50HcXuiU/vmDU6NIZI9J8+4xplF6vJPiCA1bYCJamhUaqF8AY2OKGETcv
         Hn42BrD5+c49wBn9d0j/EhjuyiGDEVrxfAbvDv5pim8bcsGg6JN9w22wYjq0o/IMCxMO
         6k+EcRnxAvPb47qaB/klAaGzyeKYZ+i6ihd+NU2SbNT6CzwKQM4XW1Fc7NyxcGdCS9p7
         6C4cuHF2rsSyaAYPYZ3yLNhdREQWuF4OWwh51uowhI6ntJerU58WqbIHIX9vW2QWCsAX
         fgVA==
X-Gm-Message-State: AOJu0Yy4ri6wqjAI60JXeQ5kRIkdFhHhfvhQ6twuGu/eS7IO27PN1iic
	bdjmeAH52GxWI+eJGWaKUqumIw0Y3Cn1NEVN/+mg9Fdo/BmBueV0ewwjILvdWpr7WmxLuxFGFhI
	S4quAeeUxBJZG+Ljez71ne3updzKVV2FnMz8Wqb+SHvv2+XldaAx0m+8=
X-Received: by 2002:a05:6e02:16c5:b0:3a7:6e34:9219 with SMTP id e9e14a558f8ab-3a76e34940dmr24436115ab.14.1731949678615;
        Mon, 18 Nov 2024 09:07:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAKvJiGb4caXR0IRCgAiaUyPAaZovWIXbMcnmJE1HwamF9spGAbpKczjnwv+bpeqGZuo18dA==
X-Received: by 2002:a05:6e02:16c5:b0:3a7:6e34:9219 with SMTP id e9e14a558f8ab-3a76e34940dmr24435945ab.14.1731949678367;
        Mon, 18 Nov 2024 09:07:58 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e0756daf89sm2304031173.129.2024.11.18.09.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 09:07:57 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <caee0ba5-b223-4d66-8db3-4a12ac8156d3@redhat.com>
Date: Mon, 18 Nov 2024 12:07:56 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: process running under Cgroup2 control is OOM'ed if its stdout
 goes to a file at at tmpfs filesystem
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: cgroups@vger.kernel.org
References: <e0dccc65-3446-4563-8a0d-1ebda4bd7b81@gmx.de>
 <tuvclkyjpsulysyz6hjxgpyrlku5zuov6gyyhjzvadrqt4qpse@bwmb7ddutwzj>
 <c77e4607-6710-4256-9aac-26251813450f@gmx.de>
 <ro4p7iarm43po64rkfy7l7mpqncelmoyztwchf6zdcnqerwbm6@z3ubeedjvcbo>
Content-Language: en-US
In-Reply-To: <ro4p7iarm43po64rkfy7l7mpqncelmoyztwchf6zdcnqerwbm6@z3ubeedjvcbo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/24 7:16 AM, Michal Koutný wrote:
> On Sat, Nov 16, 2024 at 05:04:06PM GMT, Toralf Förster <toralf.foerster@gmx.de> wrote:
>> I removed any limitation for memory.swap.max and have set memory.max to
>> the RAM which is needed for the fuzzer.
>> That should make it, right?
> It depends on the workload
> With memory.max cgroup OOM is still possible, e.g. if you run out of the
> swap space.
> I'm not sure that's the answer you expect ¯\_(ツ)_/¯

By default, tmpfs sets the filesystem size limit to half of the 
available RAM. So unless the the processes in the cgroup also consume a 
lot of memory besides those for tmpfs, tmpfs write error due to lack of 
space will happen first before OOM.

Cheers,
Longman


