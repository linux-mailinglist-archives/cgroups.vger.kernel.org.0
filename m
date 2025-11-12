Return-Path: <cgroups+bounces-11846-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B934C505A6
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 03:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0798F18967E6
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 02:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9AE2C1581;
	Wed, 12 Nov 2025 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W8LVKXrU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2616285CA2
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762915310; cv=none; b=r8iVRZMDobrMvSqKrd3E4DcKkYTt405MgHFyGqUB90Mz3k8xpYRCHJDyUI31vW4VlsAYGCr894FdvLi7oi2Ef69Y/snTquN4r1BYshgFr4Id/fuevBbxORrh1uC0zu0qINkeFN8O+U5P9RjFSSOGI5/xAtpozD7qA+00XOtXwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762915310; c=relaxed/simple;
	bh=HIVpb3Ea3Ha3qhX2lJOwmi/pBuCHvki+N/sLtjmo6aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Rl6dtPyYzoCl5dsm2TEnvXT5o37gvVDeT+fiDcGuJAJT/CulLhkTMhE3dBHpuY4WiGKfbTw5T/n2w/IgR2mP7MEg+u5r54Gimsv93l983ETnJHt6gpNCF2CwYauwK4erV7K+8S3yu7EggcZJJHcDorJrI7R8kGxp+rypYH8AieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W8LVKXrU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so235793b3a.1
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 18:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762915306; x=1763520106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0SY2jrNudIcovqQRJNc7JsWf0TAxWFuPgrrhqfAGrE=;
        b=W8LVKXrUA9arSo7nzaQgCsd3fiZpGhZnv1T2kM55JzLB0V8gXA8lT22u1318ZUOQQw
         9Q/INC2pnfzfiQ9KI1uZyYN9CggIpW7M+cZ/PYL0r1MM4zC5V5T8muxbB4nYfeQQX6Bx
         Dy2ImybhuG8sJVaLC3O4vrdhs++K5Bomx91FEsI53rBYE2uAuPMatxqGCKINZu104SNi
         RrHE43wtj+Ui6wntyuvhkcKMGguBRt09Keqc520jUc6k7dmLmqCf95E7dN7H8wsjkW/8
         LpK54y4L8In6+zbH3CSUFqv9bcTyBoDEZ7vTVqw7KiSApNlpeBc+hb6gUdBjOOOQ42bM
         ulhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762915306; x=1763520106;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0SY2jrNudIcovqQRJNc7JsWf0TAxWFuPgrrhqfAGrE=;
        b=F+Vw/rz3g31pKtTuPTaGMMnhM9wu+YfPo1x04pjjS90OEO1XgigDQG9XoNa0kGUjHs
         50QVbTbn9xet6783vY6+GOwBX/vq5fe+Ge4H/cJyr+hfUswgy7KL0HJ2T62R4SOeqcJi
         4d9Ay+JQuYx3yWrSMnx1YqwtR5Gty8KqEZpU+76TcscQFfmnXznR2YXLyRdCwNjH2Ngq
         08xUp+niIazm2CQ1rVzqn3Xf/Ve4iId+LEWC6eGt041Pf1uQ9C26j7konb7I/KayjVg0
         nOpQ09BeA3827g3eiJWo0JrGAWIpRd2jt08U+r9DI17sgR2eRFVbjZ8ePHftxb+CVb2B
         MMUA==
X-Forwarded-Encrypted: i=1; AJvYcCXznz3BXNWud25cvSrbTuxQHzrABAe3ZRwS3O9a4WkibpRYGlMxxLNmUTOKhD0qs62gG/G5F1io@vger.kernel.org
X-Gm-Message-State: AOJu0YyiD79KaC4Utd31PxuAd0j7Ri+ykdu/KeyvkgmqzpfZf02AcOLa
	qzhkEEeV7SK1OtqkxZyoJOq/+cG6uMeYSpf3GD4C82V45KcpBeciSk2dUifBV/OfrHuxPwZt/tK
	OvoLV
X-Gm-Gg: ASbGncvpvYwTkkAiZiubzZvOO7MCZ/mVoXyxN9EQjWzeTTvm57HND3AFrt6/CXEEMLS
	k9rEEp1Tj3HvBsHz6mAZXdqIfK+IiR4Xi6LZKqPB4S1hJkuV3M5hrkdT31wr6036ez3074rnCOD
	/xfNtO4sWqf5p4pa1VygaCPGjky365+xo26KYYEi3eLAShiRJKGJD1ZqwvZRql1FYuPTJdth61i
	1NqrCd3WxUrc04UX3pzltRaK9DhNP06iFbuB9BShV9J0YyX+JnjFgJAh9WaAX1QkZe1chF0hW8W
	u+1IYQW9fkJC2ODrCOkfMbuRQh2/O6RsKbHYfWDEmaEBPhl000divFj2LoEiW2YWRDmCFek7kzm
	g59siu4myThIAX8IxuNA+ruBgPegc0JPYXogJhP9DBYkev35WdxwKJA2kk7oRwp7SPC99EUKLZS
	soHCLmjDTQOLZ/i7UF6l0AS+MsrZGF
X-Google-Smtp-Source: AGHT+IEhPnMTTjFvd8o7FDm0+wskWq7IorNzJpkMdMYERkG0Z/5C/fzOHPtBRgRo7ytLz6bZEYfcow==
X-Received: by 2002:a05:6a20:3d81:b0:34e:1009:4205 with SMTP id adf61e73a8af0-3590a069af6mr1657057637.27.1762915305962;
        Tue, 11 Nov 2025 18:41:45 -0800 (PST)
Received: from [100.82.114.220] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf167e2a5asm1064796a12.18.2025.11.11.18.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 18:41:45 -0800 (PST)
Message-ID: <be07fa50-12ce-4fb9-b2f4-445eaab220fa@bytedance.com>
Date: Wed, 12 Nov 2025 10:41:41 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Improve cgroup_addrm_files remove files handling
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20251111134427.96430-1-liuwenyu.0311@bytedance.com>
 <gbmz65zlanqe7p4iw6or4jqxilpv626zp4ktf6bigxs6ni2vdo@kprxb7s73qgb>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wenyu Liu <liuwenyu.0311@bytedance.com>
From: Wenyu Liu <liuwenyu.0311@bytedance.com>
In-Reply-To: <gbmz65zlanqe7p4iw6or4jqxilpv626zp4ktf6bigxs6ni2vdo@kprxb7s73qgb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 11/11/25 21:54, Michal Koutný 写道:
> Hi Wenyu.
> 
> On Tue, Nov 11, 2025 at 09:44:27PM +0800, Wenyu Liu <liuwenyu.0311@bytedance.com> wrote:
>> Consider this situation: if we have two cftype arrays A and B
>> which contain the exact same files, and we add this two cftypes
>> with cgroup_add_cftypes().
> 
> Do you have more details about this situation?
> Does this happen with any of the mainline controllers?
> 
> Thanks,
> Michal

On our servers, there a kernel module that registered some control files with cpu controller(with some hacky code, finding and use cgroup_add_dfl_cftypes() via kallsyms_lookup_name()).
For some reason the module name was altered between version iterations.
And due to some accidents, unfortunately, the updated module was reloaded onto the server that previously had the old version installed, resulting in the cgroup becoming unavailable.

Not found this happenned with mainline controllers.

Thanks,
Wenyu

