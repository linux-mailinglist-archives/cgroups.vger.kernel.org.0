Return-Path: <cgroups+bounces-7672-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2EA94600
	for <lists+cgroups@lfdr.de>; Sun, 20 Apr 2025 02:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199B1174132
	for <lists+cgroups@lfdr.de>; Sun, 20 Apr 2025 00:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7685E1362;
	Sun, 20 Apr 2025 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYNMZZD5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962561853
	for <cgroups@vger.kernel.org>; Sun, 20 Apr 2025 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745108077; cv=none; b=N7S0VVrMmsSwlRVyTX6SqGxef+TYgFTv9fRfxfP6PZUFYw9rTJMymlOvAFzge3V1lStrjv43WX9UFuxKqndlotZh9l9/bpY4QjZ0RjtRIiqePaPd3/fi7iGSXW6tzGLbi+yWI4ctCx+IEfqaOwz61h+OBUl9hPOSAPuDc6M4St4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745108077; c=relaxed/simple;
	bh=8kTwL8I7Bqe/i3B6H+KQI1SdZVpjeHYdl2D98OU+p+o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y4ta1EpHwNcaThjhYWee5/jSnbvaaxQSs9JlR5TPWpe8X5tuy/W65QumA8RM5JqE+cnnWvhvyuzaZ+Sixya18xzsFT4YoGd2a2ehV7u6oJ3MLrWtnr8bXX/YcZRsFe5+W6WC6mFqGqINQh3GGSU+QEB7jvPn9U+6zXvY8O0ht2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYNMZZD5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745108074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuYZPgib8XXRmGrAdptMQ05xG1oDA8T8AcbL73YF0K4=;
	b=iYNMZZD5khS8VivJ1+OgtdlzFf2zZY5tGKvWFwYkknc6KjXDnxS73hcfQ49xWfpVxFj+ws
	4QvWlEKW4MQKAOTHoG/VDNV1bTAcHEE8MOinmNuqEb1PgsZCa7cQVpWULle8Sj8g6k4dYI
	jJx14GvaBKTvBomN5Aope83uI4q6wXw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-X1wW4LQNOTCs54XxxreajA-1; Sat, 19 Apr 2025 20:14:32 -0400
X-MC-Unique: X1wW4LQNOTCs54XxxreajA-1
X-Mimecast-MFC-AGG-ID: X1wW4LQNOTCs54XxxreajA_1745108072
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5d608e703so507589385a.3
        for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 17:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745108072; x=1745712872;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuYZPgib8XXRmGrAdptMQ05xG1oDA8T8AcbL73YF0K4=;
        b=NGTJ/B1zOErGcDIwuxNyPwo8Dq6OsTemTAZqUhSLnkYy0IiCkdvhbn0z9OTrwm+HFO
         5Q55xq6H6fqdqarpK6mqT348YLoK+nGBRBUqVJTmHtG+QUfRy0OSVJR3G0QSRGNrVb8j
         wcQmU426GRSLuJu/XyI8lILn1Cz9XmgkMElrPlo0rqR8B0b4QtTWqOkIXTPEgLJYJX1a
         51rAeL9Joy5ded749e8WlvXR7CGxBikuWDSady/I2SCG9uYNFpy1Tk1S9ZpH+BWe2GGx
         JpbJx+gWArL5me025PPbTXa+m7mAXyZuC5wWYbg7COAemDrPVdEDgok6PGaZA6gF5318
         Pv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCURskfqtww76sxW4QSmGMrlLgiHLv4y+j4zw4+55lgKj7rn8xatgTz3GhUraeMDF7XDiKpNnrYR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2KaqjBc0Yva+xBmSFQgdlOUQ9x1EA3aEib7LTLghPIK+ONs4l
	1up3i0Ht+KH57+LETRuLz2HQN6Yw0+TvXa2Cpjtf0qFAVt8/wNYMgeL5RCJsuer0FAhcvatwol2
	L45vGB+H83WXVu9EtI+UNqNRlnPklYvtVc67U+cwFrNwFGTuKmjPpLxc=
X-Gm-Gg: ASbGnctGD7+7TR95UiVI2E7NdatANM94br0xN3T4kT9ls1GyBuVBgCCoTgNFGFMsScC
	GJcctNv9QnBIlxzedKE0ZudYnzR0GziDQqX+ESbQpFzoC4OlHjjRCNmJ8+TO2GYyEkb6hzkCCK1
	mk2Ko19jrtOCqTGnujyvLM26BNOibfSADKep1Hy2250gRG3XXEt4OcvGp4s6+rU2qH61mE4oeBs
	TeeXTzgv0JC6rGrCLXnvAi/ZxmPhXtr2ZVTXoI7wg1V0UG5uoiFrwXcVdUy0mYpb3LcNGawkhTs
	AD8F8YhPT0mg5wO41tzkIlVxmo4h2doNHZ0BEtt5Jd9WdYp3bA==
X-Received: by 2002:a05:620a:2909:b0:7c9:2425:a7ae with SMTP id af79cd13be357-7c927fb657cmr1078311085a.29.1745108071997;
        Sat, 19 Apr 2025 17:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFta6KY5a629CPuxTTV5gcifkgwp8GViCo40FJtDLnnoc0MmUJKHFN4xPTcWiE6U+QjlnfB4g==
X-Received: by 2002:a05:620a:2909:b0:7c9:2425:a7ae with SMTP id af79cd13be357-7c927fb657cmr1078310185a.29.1745108071708;
        Sat, 19 Apr 2025 17:14:31 -0700 (PDT)
Received: from [192.168.130.170] (67-212-218-66.static.pfnllc.net. [67.212.218.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c9282cca4esm232635685a.50.2025.04.19.17.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 17:14:31 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <babdca88-1461-4d47-989a-c7a011ddc2bd@redhat.com>
Date: Sat, 19 Apr 2025 20:14:29 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>, Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
 tj@kernel.org, mkoutny@suse.com, akpm@linux-foundation.org
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
 <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
Content-Language: en-US
In-Reply-To: <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/19/25 2:48 PM, Shakeel Butt wrote:
> On Sat, Apr 19, 2025 at 01:38:24AM -0400, Gregory Price wrote:
>>   
>> +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
>> +{
>> +	struct cgroup_subsys_state *css;
>> +	unsigned long flags;
>> +	struct cpuset *cs;
>> +	bool allowed;
>> +
>> +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
>> +	if (!css)
>> +		return true;
>> +
>> +	cs = container_of(css, struct cpuset, css);
>> +	spin_lock_irqsave(&callback_lock, flags);
> Do we really need callback_lock here? We are not modifying and I am
> wondering if simple rcu read lock is enough here (similar to
> update_nodemasks_hier() where parent's effective_mems is accessed within
> rcu read lock).

The callback_lock is required to ensure the stability of the 
effective_mems which may be in the process of being changed if not taken.

Cheers,
Longman

>
>> +	/* On v1 effective_mems may be empty, simply allow */
>> +	allowed = node_isset(nid, cs->effective_mems) ||
>> +		  nodes_empty(cs->effective_mems);
>> +	spin_unlock_irqrestore(&callback_lock, flags);
>> +	css_put(css);
>> +	return allowed;
>> +}


