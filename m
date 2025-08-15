Return-Path: <cgroups+bounces-9222-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B38B28639
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 21:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629DC1895560
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 19:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198C7257841;
	Fri, 15 Aug 2025 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qam94Wjc"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4120D517
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285350; cv=none; b=ogNqEvF8gmusTE7cejwgEfcBiWxWymW+a2WOMucrjExo6BAkY842mkKS6oOzSGBLUZzPaQU3cY9+bjMeAWj7ct7gTz/q2293D4hgklKetRQ4zimgVC6XtdJyaoUUF4qo3pjcHXqC+98h419OeUuveTBp3rdKhiLXhR20oJB0TK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285350; c=relaxed/simple;
	bh=lSj71HO5GzYbckw7cBnMW50k4sxnSp1OOCtqeugcrA8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JUrJ8rYYHv4mPiO+1FntjAmwdToaecAJug7tCPXQmCfeub19eW9BRRKfrSqeZP2oU0I54qxMDgD5gfzLM+JuVHoPcxoomUovxHK7PuKj7TyXsOeV01ZeecwKrZ9dZoNQJEFddnXzLlQc7TYNLb8gWKC9EcVKqDqap3IyzFjhNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qam94Wjc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755285348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INM/nkZzXvOTsRuMaWEN8yu2b6nIHVl1/NxBWD2ETvA=;
	b=Qam94Wjc0kKcWVxlBxWki5maei5bjgh3EVtNFUy9ZSpSII3yABaCU6Lkomer9rzoVfI0P7
	DtY5AhaF8s+sXc3UGn58jb7qs5DZzOBfKK8n77wT5S12Um37zB61K55uG57Ss6TTzHSs4J
	9I+BTMSEVjZnes0I6iZCeAbZq4RC0fE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-e58QRMFFPv2VjD0l6uUSYw-1; Fri, 15 Aug 2025 15:15:47 -0400
X-MC-Unique: e58QRMFFPv2VjD0l6uUSYw-1
X-Mimecast-MFC-AGG-ID: e58QRMFFPv2VjD0l6uUSYw_1755285347
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a92827a70so48479926d6.1
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 12:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755285347; x=1755890147;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INM/nkZzXvOTsRuMaWEN8yu2b6nIHVl1/NxBWD2ETvA=;
        b=dZS1CPgy3bHQrnR28klSA/eUXaG8FNwWAxzuEF6FvvzfLhGr7uiL/VSU4oxuG9fUHA
         olzwatvCuupCXBmymL0vbAL17ZsSxXhDA4ESkgJ6/FkN/7gnyeyVSr1PD7cQTZVaHG9f
         2/ihe23SU9/WOMPTJFIlT7Xr4eJ9QnHZ1NjIMjHF+hjaqmfjwpK9aEIlDCSRpgFemBCp
         r15PWeGvKzdXiQ8CmC6B/NwRsgZWMaOz0ZKlO1RWbszMzi4Ke9kcanW4SxWt6wUHF3Pt
         33IxWOidFSX6qU3N0/zo0yhbKeDBLtdGZK2UCXUu5vaO4ons4vwDA2nocdUf/gnFKR/K
         izog==
X-Forwarded-Encrypted: i=1; AJvYcCUQ70mbsgbpAjh1echDIuj+yeUiTRUFayYizgcD86SsFwFiLHlN2T7peStE0kDqGqJYLqJbiLmu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/X2NtIdOdbHIbxq7qAMx40JE2JuXtTwUPm/z+wabgY9PjaQE
	b10k43Imx4HYEWco6BPSiU80TOaLyCPoJeR0WK3CHjB5w2fEUfzkrXRtd63yEyR7xgHCpUCZh8Z
	c2fI8/L1PzG2qDsidtUJzrhu4+Ly1glndf5X6s5DryfZVVlyGu98bf3SvNbg=
X-Gm-Gg: ASbGnctZnfltjLnlt12mT05tZ2AVPg4NJf+96kq8iCS20FtNj0537q8zu25gle+vG19
	1RFli1ac0i1T40PtHrDUh/RiAt1F2k5j+gq3Nghn7D+qjhA1YBZshjXHFzZkQM6ZFXZ3cujnpx9
	PHhjsQyKZd86rUn4rQujWSBWvJGbAlLzwoaC1icUJEZzQ75JQkk6wy3m0uuuJMJ0X/+RWDNhJzq
	mA2dl9EUQ6FKnSIOPHvWU3S9uxFcvC2kdO5hy6d2w9fwGHnKFAybMgGiOSYYjPYTqfvSsIGropW
	GX3M+p4w9CT4KIeVEwvDDYoTdA42wLEbvXabAxnUs+zD3hHLQSGIKCPwpnQU80Vbfupk+O6MhQ6
	1ABzEEd0oeQ==
X-Received: by 2002:a05:6214:2522:b0:707:48b3:132 with SMTP id 6a1803df08f44-70bb04c04femr2029906d6.0.1755285346264;
        Fri, 15 Aug 2025 12:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6iyDjW6RyozXA8YvlziiALssSDGwSrln6G47qwGj99VGsN/w0n7YA7sGWwplO+Ka5maXxjQ==
X-Received: by 2002:a05:6214:2522:b0:707:48b3:132 with SMTP id 6a1803df08f44-70bb04c04femr2029486d6.0.1755285345832;
        Fri, 15 Aug 2025 12:15:45 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70bae08c0f9sm7904296d6.11.2025.08.15.12.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 12:15:45 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <15b47a34-ea8a-4a07-bc1e-5ba886010721@redhat.com>
Date: Fri, 15 Aug 2025 15:15:44 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 3/4] cpuset: separate tmpmasks and cpuset allocation
 logic
To: Chen Ridong <chenridong@huaweicloud.com>,
 kernel test robot <lkp@intel.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com,
 christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-4-chenridong@huaweicloud.com>
 <202508140524.S2O4D57k-lkp@intel.com>
 <bd043822-29b2-49f4-864d-6658741f572c@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <bd043822-29b2-49f4-864d-6658741f572c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/14/25 8:44 PM, Chen Ridong wrote:
>
> On 2025/8/14 5:28, kernel test robot wrote:
>> Hi Chen,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on tj-cgroup/for-next]
>> [also build test WARNING on linus/master v6.17-rc1 next-20250813]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Ridong/cpuset-remove-redundant-CS_ONLINE-flag/20250813-164651
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
>> patch link:    https://lore.kernel.org/r/20250813082904.1091651-4-chenridong%40huaweicloud.com
>> patch subject: [-next v2 3/4] cpuset: separate tmpmasks and cpuset allocation logic
>> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250814/202508140524.S2O4D57k-lkp@intel.com/config)
>> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508140524.S2O4D57k-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202508140524.S2O4D57k-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> Warning: kernel/cgroup/cpuset.c:422 function parameter 'pmasks' not described in 'alloc_cpumasks'
> Hi all,
>
> Thank you for the warning about the comment issue - I will fix it in the next version.
>
> I will be appreciate if you can review this patch. If you have any feedback, I can update the entire
> series together.
>
Sorry for not responding to this patch. It looked reasonable to me. I 
did miss the error in the comment though. Fortunately it was caught by 
the test robot.

Cheers,
Longman


