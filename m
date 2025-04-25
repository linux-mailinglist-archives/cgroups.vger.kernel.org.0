Return-Path: <cgroups+bounces-7821-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E415BA9BC7D
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 03:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94751B87F60
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474AE502B1;
	Fri, 25 Apr 2025 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHrJP95m"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710094174A
	for <cgroups@vger.kernel.org>; Fri, 25 Apr 2025 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745545796; cv=none; b=dEWnhUYnNNgDljXvEyBNd4hlThuOTd4eKHH3M4w9xI++mFuHJdXo+ABqZAR1vuXOT21/6P7fsIRwWKGay4BhejqPu/fey4gfKNpXYTEUQC+7b7rqGcFtTQfQYld/+3j1ksuZxNk34rClp8JdWMF0hxHnNgy08L97M1qTcNVjVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745545796; c=relaxed/simple;
	bh=gKvGgoDyaqN5CJ9mJmsU2FpaC8qrv6VrrlpgvToUL2Y=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O4xQIaP2YFJDzb2FysjkQ6qFAlCiz9u0nhBznAUmJZIobo+LTRKueWgrHAG0SsGsWMg7coWheNdTd0JsDA0wgJmw1A0sKzpcw58rrQIQMMZEWG7ZIk4E1ypsM/A/FdA+5VHzFLJ7vbKgZzPPXCmygG/ChSccVpFfzr86KQ4TWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHrJP95m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745545793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuIu6FpgSdCcAuTLohsFBTj2vc6nnMTkVfa1ZAvd/hA=;
	b=HHrJP95mgVqUbpzBpsVdnhuhaNdlNzvBQ++ne+qHQzX7Ptgb38vUAnJDrWQxB8Ed5VyEqE
	TvbxhEBEkMTd1fAgRSoIfQ+6CvFqag5j9nBcohLWuEKWyzhngxQKQQqvZH3RrpRFgL8HiD
	WQt5d5JVjgXmz+Upivg1zM6b42u8F/w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-7X0_rxrEN6q6mISbicv1Fg-1; Thu, 24 Apr 2025 21:49:51 -0400
X-MC-Unique: 7X0_rxrEN6q6mISbicv1Fg-1
X-Mimecast-MFC-AGG-ID: 7X0_rxrEN6q6mISbicv1Fg_1745545791
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-476870bad3bso24724521cf.3
        for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 18:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745545791; x=1746150591;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuIu6FpgSdCcAuTLohsFBTj2vc6nnMTkVfa1ZAvd/hA=;
        b=rylA4iEe3aER7hors8zKHm0p7PQ6wnDaXDTgaUyQS/JrX4O3SmqYSKncP398+jGrPH
         kFtIyz+c5H57KxCSShUjjZ9FCQGLOJW1hUp5qTihoD9l3KFoAt1k5sywjuZ92pW8yDFH
         358RwOh2/WVlYSlmJ5ESsr8ra8zmpsz9by913AO49MD7EChEHxh+QqKuNCz9t877Ij4E
         W7wLI9sbe3W1j7V23WMc6hy8QRRCGkvmVLBUCVmg6xuQdDa84OBeCgD1YriLBOkMJh/n
         Gs4DCDbQdnfpy0pD4ybrt1E+Y6wEOpwZ56fN4p3N+fnOx9MpCjTCFl4DBUmx8oE8MIz/
         r3zw==
X-Forwarded-Encrypted: i=1; AJvYcCUDYmo6gQ0E30CvGZpTBNHlELCnExiRjr11FgefIH15SqG3UY3iCopv/nPcUo8ewppJS6RLG+lc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7rkcyfl2nNjkZRNsB9qBG4H4k3TLLO6VSJpeukNnUuzCYSeaG
	A8lAqyhuN755RJuxvVHCeaRTIWyNI+Nde2otnwovZepaHjkomIJdazJmI+BbBm76gY6WGvMMDS3
	m14pNfDchdbAmkPZ15zadIs4BdK6Ae2P11dCzjQ3XP5jskz9jUK15yFPsK4P6jj4=
X-Gm-Gg: ASbGncupmSkGWDP5aVp2p5F/rO3+YSvWCbXmp8wI2IbRD5rdTm7xNSghvK7hQ3rtynO
	O7BmKk2ZlkyIJUjh6VVq8oIegiE0Solh3Vz89e+8cg/ZK0/3ASm84Oeb41V+U7vPjCm1XZMDk2K
	aC6JFtS3tZb/1kdXJQb+Ag4JhNYHbJAeFjDi7HXorW+kqGoW2YdJ0B7fX3HpTGQ1hlKk+9PGUUJ
	YBtxtWKTMp1N/zeazj5wdiPZAlYPnGHsIjDQBRTIFVaHkQWil9FZH83obE3jb5Sk6de6Yev3UTD
	V+++oJtu1vE0Ns6NuXHFuBXdEynM82wEyJ6T4YYKZo2Df7OVpGtOqM4ggg==
X-Received: by 2002:a05:622a:24d:b0:476:7e6b:d2a2 with SMTP id d75a77b69052e-48024a7dac2mr8362721cf.35.1745545790976;
        Thu, 24 Apr 2025 18:49:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAJgknqPbNDIbXMiiiqKtYRR3XWPVLR30o7wYomwXhVSzOlUPsR/NBaj6Mbpm5BZORkv9JUg==
X-Received: by 2002:a05:622a:24d:b0:476:7e6b:d2a2 with SMTP id d75a77b69052e-48024a7dac2mr8362551cf.35.1745545790675;
        Thu, 24 Apr 2025 18:49:50 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9eaf2867sm19489011cf.7.2025.04.24.18.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 18:49:50 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com>
Date: Thu, 24 Apr 2025 21:49:49 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup null pointer dereference
To: Waiman Long <llong@redhat.com>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
 <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com>
Content-Language: en-US
In-Reply-To: <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/24/25 9:33 PM, Waiman Long wrote:
>
> On 4/24/25 8:53 PM, Kamaljit Singh wrote:
>> Hi Waiman,
>>
>>> On 4/23/25 1:30 PM, Kamaljit Singh wrote:
>>>> Hello,
>>>>
>>>> While running IOs to an nvme fabrics target we're hitting this null 
>>>> pointer which causes
>>>> CPU hard lockups and NMI. Before the lockups, the Medusa IOs ran 
>>>> successfully for ~23 hours.
>>>>
>>>> I did not find any panics listing nvme or block driver calls.
>>>>
>>>> RIP: 0010:cgroup_rstat_flush+0x1d0/0x750
>>>> points to rstat.c, cgroup_rstat_push_children(), line 162 under 
>>>> second while() to the following code.
>>>>
>>>> 160                 /* updated_next is parent cgroup terminated */
>>>> 161                 while (child != parent) {
>>>> 162                         child->rstat_flush_next = head;
>>>> 163                         head = child;
>>>> 164                         crstatc = cgroup_rstat_cpu(child, cpu);
>>>> 165                         grandchild = crstatc->updated_children;
>>>>
>>>> In my test env I've added a null check to 'child' and re-running 
>>>> the long-term test.
>>>> I'm wondering if this patch is sufficient to address any underlying 
>>>> issue or is just a band-aid.
>>>> Please share any known patches or suggestions.
>>>>                -          while (child != parent) {
>>>>                +         while (child && child != parent) {
>>> Child can become NULL only if the updated_next list isn't parent
>>> terminated. This should not happen. A warning is needed if it really
>>> happens. I will take a further look to see if there is a bug somewhere.
>> My test re-ran for 36+ hours without any CPU lockups or NMI. This 
>> patch seems to have helped.
>>
> I now see what is wrong. The cgroup_rstat_push_children() function is 
> supposed to be called with cgroup_rstat_lock held, but commit 
> 093c8812de2d3 ("cgroup: rstat: Cleanup flushing functions and 
> locking") changes that. Hence racing can corrupt the list. I will work 
> on a patch to fix that regression.

It should also be in v6.15-rc1 branch but is missing in the nvme branch 
that you are using. So you need to use a more updated nvme, when 
available, to avoid this problem.

Cheers,
Longman

>
> Cheers,
> Longman
>


