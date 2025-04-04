Return-Path: <cgroups+bounces-7360-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632AA7C260
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 19:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED823A7C8A
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13B0214A80;
	Fri,  4 Apr 2025 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+AVct5s"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA57101EE
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787539; cv=none; b=WUgjj133beyQK5SJZIsxd/s8VOEitkmdWKrmr7P/6FAFcXhOkeOFhubmtcPfKibd8/VuiZW6AHNRFfbuIC6V1NWNy/WAND50rd2qRzNhz+mauWFtMnn0q2+OH8+lJHF+PIksT2J9k3lc/73i4FUUfkKTJYo9ycz9EuItrGPUkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787539; c=relaxed/simple;
	bh=UIONdw5KXPgsmLhBGCkNGI+fIM7vKA5uHxq4ySw2mXA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s4otgR3d69jdpNdGNSoiUxC5kcrKFuCmOKSPzQDKTpuIBLoNYfjs8L8Mz9CaRJCDRqfD9DogCjvpTqFiKc1HbFIEYur8kxm9eE14h+61N2j/NyiQPEXYu8IclDlB+DCpVDeePWxgnYL9swhRr/h4xNixwWG620enmNqTXLOB0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+AVct5s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743787536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zY1OdvQqmeKzz5CfMBTTTFp4WcoqAgk+p41C7P+KQBs=;
	b=Z+AVct5s9URF6i9nDm+/GyP9PESXVy0zxt7HlRXExEu6BdE995eWhtUHPE8MIgXsDBqsHm
	3t1iuXUnrbjt6rlJIFSvLjvCb4Q8HFo/YGOSJzdXn6Eq0NomObLaq4oFdmLyz6RZ59vPEB
	RDweDkjBrDK9JR/D+fdVa3uQQ+/zEc0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-HBJxU5-kNcOBByJbKBa4pA-1; Fri, 04 Apr 2025 13:25:35 -0400
X-MC-Unique: HBJxU5-kNcOBByJbKBa4pA-1
X-Mimecast-MFC-AGG-ID: HBJxU5-kNcOBByJbKBa4pA_1743787535
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-476a8aff693so52657221cf.3
        for <cgroups@vger.kernel.org>; Fri, 04 Apr 2025 10:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743787535; x=1744392335;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zY1OdvQqmeKzz5CfMBTTTFp4WcoqAgk+p41C7P+KQBs=;
        b=CjdKeIsaYdGcQGUvX64sMw79z9CwFCxgHZx1Kszp698HA3k0vfKgDxMtx+bA3avL8w
         dfev/8HldAtoH9o3HGFZ6BnSkSz8o+3I1lloh/wtcIOb8svjsBJUfkcFSM4o876ddt/t
         E84TzJ76q66Td/AzxnqUbjh06tReMOMTfHpEqCO72hDevnvN9exvF7RXVvduRS5z32Du
         ICTkTrBtkxKGfMP/fsOCW7C1XLTBcEq8VXlkkovYPnoDEPXHp8qhKd4kXaXqTqMz5BId
         VSU7lNTTkSEA36eyzYBKO3zPzfTb6Cah4rv/KxCEl38C8ub5y2DbMCWfRexYLH9U1DKW
         yKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcmXYLTiItahpeMoxNgDSYdWMHhtuCd7Uv4j58P2JVZFlMJQrKwD2PJ11J+WlwNON/HI2KKqd6@vger.kernel.org
X-Gm-Message-State: AOJu0YyOg0y9VGeIFiX3YeQ80U0oeJIVAXkJ6R14RJ1oV/WIAVi/fIus
	rHNkHSxvqOcLTqUqrxBTHBtiJZm/DI3nw0vbEEG5bH7rISCvmWGvhx5CCMgv+Z8UZXiOBednfJ3
	0CrS1wNkyDfJ45hKtd94O86kVU8li7Y+iBmQGuFsDB2ZX+88ZmZB+PK0=
X-Gm-Gg: ASbGnctJBUb3u983Jv9FV/J7gET2UnBAzLpL14wbcMVi0X63YK/Gc/y/4vgkUwNbQuj
	LMUdDyHaiJMnVWvrxVff6xZdMhIkZed537q4HlCbzUV3tUPmHSaETKFo4zbSZfOLZJNN3QNvBqc
	cprfHwX0Kr5ukICjntVFyYrU+JDePEc2ZpVxFj9YsSc39hFqRTHLM4Q0cQ82gIImSKq//3zoWOr
	vZO8lmmK5lvcbbMxOaSdM4bzLeQUCzzte6NpBlgKudbEUEWGC+Wp1mtFzgmvhFPRPLSuCuIyRXn
	SfSz4BoIQqKUWCnGpDaWkH7Tk/SIESsQzRobNb/wrctj+35Izw/F+mZwulmorw==
X-Received: by 2002:a05:622a:24c:b0:478:de14:135a with SMTP id d75a77b69052e-4792595adafmr51651971cf.20.1743787534886;
        Fri, 04 Apr 2025 10:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPaEDXj6BQIt1pawQwBSb2n8E48wuGD6upHv6D0WAjJO96YQubjDzEqlaf96Y8LIMcvLc1vg==
X-Received: by 2002:a05:622a:24c:b0:478:de14:135a with SMTP id d75a77b69052e-4792595adafmr51651691cf.20.1743787534569;
        Fri, 04 Apr 2025 10:25:34 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b0883f1sm25312231cf.42.2025.04.04.10.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 10:25:34 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1ac51e8e-8dc0-4cd8-9414-f28125061bb3@redhat.com>
Date: Fri, 4 Apr 2025 13:25:33 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20250404012435.656045-1-longman@redhat.com>
 <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/4/25 1:12 PM, Tejun Heo wrote:
> Hello,
>
> On Thu, Apr 03, 2025 at 09:24:34PM -0400, Waiman Long wrote:
> ...
>> The simple and naive fix of changing the operator to ">", however,
>> changes the memory reclaim behavior which can lead to other failures
>> as low events are needed to facilitate memory reclaim.  So we can't do
>> that without some relatively riskier changes in memory reclaim.
> I'm doubtful using ">" would change reclaim behavior in a meaningful way and
> that'd be more straightforward. What do mm people think?

I haven't looked deeply into why that is the case, but 
test_memcg_low/min tests had other failures when I made this change.

Cheers,
Longman

>
> Thanks.
>


