Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA293CC590
	for <lists+cgroups@lfdr.de>; Sat, 17 Jul 2021 20:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhGQSyl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 17 Jul 2021 14:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbhGQSyl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 17 Jul 2021 14:54:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9AC061762
        for <cgroups@vger.kernel.org>; Sat, 17 Jul 2021 11:51:44 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 37so13918616pgq.0
        for <cgroups@vger.kernel.org>; Sat, 17 Jul 2021 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7W9cdpcFBJJS0JLbmMCkBOvi8E5p+r1Z1gKFFynRQDU=;
        b=rsqMLJgcK6fq8G0MUqltjXw06Aq8/3ZpkYLJPYDFYKyPTBdSrwNwIThmxlkvH7Bld9
         axVVt+nmfeUDQClTdycTcyLMAk6PM/rGoDdSEE7E38Zp/F9M8553U90UbubAcl7IOf3i
         G/V64Jm7ybdDURNn86qt0IInWc0jcZgE/VtVOXUBO8t7lUUmUdUU+XJtiAzmCGkIY+gZ
         zU+roz0sMtMvtPw7/azofKki4W0rRLdfMjsGzibf1bOpu7d6onnS9IuF8JWb9nLy5Cwc
         OXXncYWPhs+qBaSNv/jpwtGt2MaRRnvfS4ASvVIPajfDNZ8eXIFBSfSOI0rjetcx1pMu
         PYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7W9cdpcFBJJS0JLbmMCkBOvi8E5p+r1Z1gKFFynRQDU=;
        b=K6hPJKATgpP0Qnf1eGZ9AO/m/aOXHXw5bLwnV4RhrttYhjUtHzPikhaac3l463EgL+
         7Wvk/EJ+0ljNhOFrKGLwXDCGTMjBaVPRRFhPGKCGUK1ER8sMbFIOQW4DTTsR3DmPD00p
         p2jpmTcvfHuBBreWN1Q7WJnnBPYIIta5oBYV9TCmWJO3NbiySlUJwDMgo/GIHYqSREfv
         PS1AU4Uto6JyHLSVYMLzPvK1FmL2wXyxCocx0Ne0PEmdSi5gqqdrdxTN4OhAopETFeXC
         qqjbyY6XaS86JOH+qs/bGS9wVaLtG9iJYlQIKY6vqjeNDYAF6nKm2I+7Z6Mo2aadjyDH
         EtYQ==
X-Gm-Message-State: AOAM5338S7F5/LtT0lP4WLm3ZYh6CfLZ3U0h47ZCE4anQDYcLyDcW2Cy
        9ia/YmxNHzu47KCuOflssO04Wg==
X-Google-Smtp-Source: ABdhPJw9fhrPn1zhN3Vk4bwdofv4T2uk/0ucOIlqOKDQphxFTotdqQySRu8VhaEOk8QPp8CenbEfSA==
X-Received: by 2002:aa7:8254:0:b029:2ed:b41:fefc with SMTP id e20-20020aa782540000b02902ed0b41fefcmr16847677pfn.42.1626547903015;
        Sat, 17 Jul 2021 11:51:43 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id bv22sm8386964pjb.21.2021.07.17.11.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 11:51:42 -0700 (PDT)
Subject: Re: [PATCH] memcg: charge io_uring related objects
To:     Shakeel Butt <shakeelb@google.com>,
        Yutian Yang <nglaive@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        shenwenbo@zju.edu.cn
References: <1626519462-24400-1-git-send-email-nglaive@gmail.com>
 <CALvZod59c1TmiGA5afoy=eM6PH15hEpxsfo2+GJ48yExLz7odQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f2bc2044-bdbc-a1ac-1c5a-5d8c53d48b94@kernel.dk>
Date:   Sat, 17 Jul 2021 12:51:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALvZod59c1TmiGA5afoy=eM6PH15hEpxsfo2+GJ48yExLz7odQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/17/21 11:03 AM, Shakeel Butt wrote:
> + Jens and Andrew

A lot of these are probably (mostly) pointless to account, I suspect
you'd get 99% of the way there by just doing io_mem_alloc(). But as
far as the patch is concerned, looks fine to me. If we're doing all
of them, then the patch is incomplete. If you send a v2 (that's for
the original author) I'll be happy to get it queude for 5.14.

-- 
Jens Axboe

