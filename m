Return-Path: <cgroups+bounces-7675-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 137D5A949BD
	for <lists+cgroups@lfdr.de>; Sun, 20 Apr 2025 23:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E0B188FD59
	for <lists+cgroups@lfdr.de>; Sun, 20 Apr 2025 21:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300491DB377;
	Sun, 20 Apr 2025 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rfl8jbPh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436514286
	for <cgroups@vger.kernel.org>; Sun, 20 Apr 2025 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745185703; cv=none; b=P1SEU9xpjmuVD2q+HW6XnM6/eS2E4lZPaw7u9SOyKuv/mi3bcl5Bo1MCQVxaNQ6UznJ7MoCmV+TuIzwTaehWg+38pr0qdoSTnA4rWz67ESYwNqQQd2KZYp3tRy5XFhtLaSzmpatXkR0XBmeugaKf+DYr2n50DtdW9hVxBEtJBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745185703; c=relaxed/simple;
	bh=IBu7tifNB1j2tCG4W4YMRP4oTCUk0PFSrFVfM3EZhOw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kWv4/vbDn+WwNYEbtCeC+PyQyoY0J9yI9sKaWcu2O1txZEGp+OXRKCMDrupZXXsR3Tt1r6N2YRoXGW/QTfHeONG+t3qKycuwp07GMqnixRotM2zkBJ8OzylnsfVxYPBBJZu9osDnQjhjR7VQr3jscbzmjvyoS9qQRrMrd5/atAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rfl8jbPh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745185699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOUfeRWcjMIh7HWgzJ0PWrB/E+2a4XRZ58CSESwgEfQ=;
	b=Rfl8jbPh0YbGnjGzeGh/E1ojcbOSQSOnrl491TOqsWkwj8I2pZOHVNaMOrwEDYJ/WpecGx
	6RQhg6OMPslH1cNJu8GsMcVU6mesQkHGWzQ0fUpnJMYLANWzb5Z8sS/9GXQihfHp26kkka
	Y1neK0dx5BnkyXso8P3GBispa4WB2HQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-VjLVd5QvOLSa4Zt-66Ybfg-1; Sun, 20 Apr 2025 17:48:18 -0400
X-MC-Unique: VjLVd5QvOLSa4Zt-66Ybfg-1
X-Mimecast-MFC-AGG-ID: VjLVd5QvOLSa4Zt-66Ybfg_1745185698
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8ffb630ffso54785586d6.1
        for <cgroups@vger.kernel.org>; Sun, 20 Apr 2025 14:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745185698; x=1745790498;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOUfeRWcjMIh7HWgzJ0PWrB/E+2a4XRZ58CSESwgEfQ=;
        b=H3iRO1K3H1f0DZKI43PhPzKiIyWHokTZDWHEo74mPeLim4B0jgdNLTN6J9vshyf0O9
         wQ5dGRYox8Cx+dtopv2KlI68VRhwtOtWv/VudozIwWtJ6wK25yjsTpXcb3DMRNqR6GOw
         E0RZ0c3LLAjdeDL9p0xuVuO8Ty1IBx4l2Xf68jae7Vft/cCWaH5JBo/3ji8f92N3GHi8
         OcPK3cGd3ywSCB0ewbFMFcDl0xtrx8vYu2/vR3BVANrwjz6ZTaokpX2q7USbcTcpTUqJ
         MY9SuFiQu+LgBqy/yoEAx3k6dR+oTuGsrUFfUTpnwaWNVfbHQuhghlcqr6iXhbyc8b3/
         X08g==
X-Forwarded-Encrypted: i=1; AJvYcCVlVVLorybQOgvpIK94ybPrR+vjR14k8Xm6BJD5qUsh0ciO+x5Oqcw5cW7uBr6Es2EhTFl+2YF7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9cXztic5055pmGYcH+Kk/4K1jzpoH1WU40pEBID78rfp7fhfX
	83/2wLyiXz+bvL+mMMqiCady9CfetXwFJBfeewiHtsFlM8a3y0iKgQq/F9oTVzwZ+4z8/UO8c3+
	XF/ok1FZJJ9x0IK2ThGzrVnU4AKtj/MgimR31CB7s25VGHUAPb9/fMd8=
X-Gm-Gg: ASbGncugffqSD1EGNh0SWGCxGpI6tmw7Zn1yKq/wjmL3JHMbIO9rudfCc+WAuOH5XpL
	bFQMdK+ccxF8zZF7Rp7qQDhuIjYH0Xrbfj43qIerXlb+1mAU5qohTzRYaQSMKjEofQkN9JwaX42
	WxFIPrZflwFzPX/BwoAtesnh+wri4kQL1pTPwzuAqu6wLJhNU7tPOmLQK5QkNqGh2eu1hhVX43M
	NcaUmJW6w1/JOf9eTruQN13D9LeUEEqPHGpD9Ng9gP/aqkEwIViMlaLFArjyOOt1sO7xuycZ9At
	iWbIqS3/dIggcEP/qV57s08OX/AS+Oh7oOgjPLcDxA9qC0GGYg==
X-Received: by 2002:a05:6214:20ee:b0:6f0:e2e1:50b4 with SMTP id 6a1803df08f44-6f2c4665552mr155639776d6.35.1745185698072;
        Sun, 20 Apr 2025 14:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1rjz0rbTdMsGxlXep21QS1BL8dfWYnSrJCLKXWkQdNHadHwWjUHhvmnzBn0KbSPKMCrPC5Q==
X-Received: by 2002:a05:6214:20ee:b0:6f0:e2e1:50b4 with SMTP id 6a1803df08f44-6f2c4665552mr155639546d6.35.1745185697701;
        Sun, 20 Apr 2025 14:48:17 -0700 (PDT)
Received: from [192.168.130.170] (67-212-218-66.static.pfnllc.net. [67.212.218.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b0e2b2sm36456396d6.28.2025.04.20.14.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Apr 2025 14:48:17 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0033f39f-ff47-4645-9b1e-f19ff39233e7@redhat.com>
Date: Sun, 20 Apr 2025 17:48:15 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250415210415.13414-1-longman@redhat.com>
 <20250415210415.13414-2-longman@redhat.com>
 <psbduszek3llnvsykbm3qld22crppq4z24hyhsp66ax3r2jji5@xhklroqn2254>
Content-Language: en-US
In-Reply-To: <psbduszek3llnvsykbm3qld22crppq4z24hyhsp66ax3r2jji5@xhklroqn2254>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/16/25 5:25 AM, Michal Koutný wrote:
> On Tue, Apr 15, 2025 at 05:04:14PM -0400, Waiman Long <longman@redhat.com> wrote:
>> +	/*
>> +	 * Child 2 has memory.low=0, but some low protection is still being
>> +	 * distributed down from its parent with memory.low=50M if cgroup2
>> +	 * memory_recursiveprot mount option is enabled. So the low event
>> +	 * count will be non-zero in this case.
> I say: Child 2 should have zero effective low value in this test case.
> Johannes says (IIUC): One cannot argue whether there is or isn't
> effective low for Child 2, it depends on siblings.
> (I also say that low events should only be counted for nominal low
> breaches but that's not so important here.)
>
> But together this means no value of memory.events:low is valid or
> invalid in this testcase. Hence I suggested ignoring Child 2's value in
> checks.
I understand your point of view. What I want to do is to document the 
expected behavior and I don't see any example of ignoring a metric for a 
particular child in the test. In this particular test, I did see an elow 
of 17 for child 2.
>
>> +	 */
>>   	for (i = 0; i < ARRAY_SIZE(children); i++) {
>> -		int no_low_events_index = 1;
>> +		int no_low_events_index = has_recursiveprot ? 2 : 1;
>>   		long low, oom;
>>   
>>   		oom = cg_read_key_long(children[i], "memory.events", "oom ");
> But this is not what I Suggested-by: [1]

I was referring to the suggestion that the setting of 
memory_recursiveprot mount option has a material impact of the child 2 
test result. Roman probably didn't have memory_recursiveprot set when 
developing this selftest.

I can take out the Suggested-by tag.

Cheers,
Longman


>
> Michal
>
> [1] https://lore.kernel.org/r/awgbdn6gwnj4kfaezsorvopgsdyoty3yahdeanqvoxstz2w2ke@xc3sv43elkz5


