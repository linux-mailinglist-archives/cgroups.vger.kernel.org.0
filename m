Return-Path: <cgroups+bounces-7010-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ACDA5DE0C
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 14:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017B916E4D5
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78912459F6;
	Wed, 12 Mar 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTKjr61L"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC11E48A
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786348; cv=none; b=Mv8L1hQjDKrONvjJ/ghe4wr8mukecAtWjdCPd+sja1t9VrIDSC8+OEvyzhLkuoxHVvdfcWYKsdzAQdCMTqEkel2zV4pJgqWmTXtwcAlSFw/+XIlh/LETcXt6N7OD2A1Ejl//FsUIgO2sXZHLl8ydvZsU+AoEn7ePVT2vHgNqr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786348; c=relaxed/simple;
	bh=mCSI4g63ZRxOe8nfZLB64gzPRCruOM7oaM6iEJmkZE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IEGVzG+thqC0J6t94Y4MNTqBoLzSjM6d9altUEsU8rHEGuK7k6OmZ3yIzQL67lOK5CzhbSzn7Z7qM9e1tClhRg+z4jvcsU64tteOaZfj4LKpbMfCA+axswG5GgpJRMTdOTeYPNRKMReoxDdUhLe+4yOpizqfO0QAPKYhTNzcokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTKjr61L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCSI4g63ZRxOe8nfZLB64gzPRCruOM7oaM6iEJmkZE8=;
	b=VTKjr61LBeBIggjxTkH7JI9s4j6ZW8KeG8LMXsdrS+x0xbiGN9bPH7bqcLv+HcAXcPYAll
	kQ4OcPAOHoN4IIt/ad1ThVhcZDTdbbHFUZVUuuoMjVvOwgT8I33KcPA6uSorbqqkhHdsti
	9K+427GqECf/enQwUWe2902qrDwgyQY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-VhzHu6DtPpK_ZWOcfpkE6A-1; Wed, 12 Mar 2025 09:32:24 -0400
X-MC-Unique: VhzHu6DtPpK_ZWOcfpkE6A-1
X-Mimecast-MFC-AGG-ID: VhzHu6DtPpK_ZWOcfpkE6A_1741786344
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so10259225e9.2
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 06:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786343; x=1742391143;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCSI4g63ZRxOe8nfZLB64gzPRCruOM7oaM6iEJmkZE8=;
        b=MBjrw1sJqYPo7wW65Ox1nHayqaJXHp/bUTCB2r9KrDwG/aYZOO6qO89MaU1ofsw8vR
         UV7VQ9xzFJ8r+MJneUpQ/ffegPNrWgkuRrkp3qBtgp+MfPYsOnX/E0BJ8tMS+VbQRUG4
         Pn+f90/EqPY/SVwZGSX4+2vCiF5QOzDyuUT0ADizL7jVHNO+tlnC35skxTcUL1aYmvoZ
         NXkUsuDb6jNNe9Wd/PA2dmDci3l9NPQ/K4n0DPTpS/Lsy2ZlF5XEefACn5fsdk81/d2z
         QCzbQQ7vBv7MhEmpXpuppWycNVU+pdZBK7gkUUWvqZRil5jSHqSvBF1ge0Y3Q8hVq8ZJ
         DuHA==
X-Forwarded-Encrypted: i=1; AJvYcCXx0zlQGKgiV/sgLhzLYPTak9TGn6O4YIct2V/PdXfT3chyPiiItaEQURdlNdiHxUYlW0fQNgW7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1IxX2WnkzQWeThEacBuZLLG8Idiv+04EmuaBysIrw4j+FFGFt
	x52JhWP01PHn7I1uDHcFNrCfldm0I4vl4214XGBRLBBZq5JhvL39Gajski5JcLvwrroPSNtgBjo
	lbPGj6d+JeUJyRRSfBUT8eK46p3onPJPCVFd5IUxrmHEQUGdC3OgYfS0=
X-Gm-Gg: ASbGncujeSKpAFONDAfH4Zk0uh54vZAfZYyofirBkJSRy61DDFoDVtkC46KVOxguoFY
	zLmWbLQZgVNqpk9hwa5fFyhaexTZ9BHokS4/ciqy3kRSi4u2oAzypwCU3LtVK5Ety+3AhRe/5dZ
	mGmKQq0BNA7Aw3yrB4z4wLlIL/kleAFbW2tEXU+22r1UwihkDC+CT8zFukgvRIWni+IQ024Nfaa
	0LPKCC4R0YVTcDXbLkxkcrtbw4F5bdmZ4KUES45QZix96arNhEyHG4rdYJl3pM6NXfuevnx3dNh
	Cx1Su+qofwEPoLqT9ZrG1m+kunqqEe5XwxwbRk0Trr9lkiN0Vin+uObxwBdvU15gegiU/qWlatv
	8
X-Received: by 2002:a05:600c:1c25:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-43d073805dbmr42351235e9.27.1741786343664;
        Wed, 12 Mar 2025 06:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhPw8NJ1lb0q/giTLWm+iKpfer34XUJS5eQYqmpFdFHzSRWp15aA/RZ5hULR6/Yxjpn+5pew==
X-Received: by 2002:a05:600c:1c25:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-43d073805dbmr42350935e9.27.1741786343296;
        Wed, 12 Mar 2025 06:32:23 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a78dac2sm21127785e9.29.2025.03.12.06.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:22 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef
 <qyousef@layalina.io>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 3/8] sched/deadline: Generalize unique visiting of
 root domains
In-Reply-To: <Z86yfz-pIHHqC5TP@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yfz-pIHHqC5TP@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:21 +0100
Message-ID: <xhsmho6y6pe6y.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:35, Juri Lelli wrote:
> Bandwidth checks and updates that work on root domains currently employ
> a cookie mechanism for efficiency. This mechanism is very much tied to
> when root domains are first created and initialized.
>
> Generalize the cookie mechanism so that it can be used also later at
> runtime while updating root domains. Also, additionally guard it with
> sched_domains_mutex, since domains need to be stable while updating them
> (and it will be required for further dynamic changes).
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


