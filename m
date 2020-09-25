Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41B5278AF2
	for <lists+cgroups@lfdr.de>; Fri, 25 Sep 2020 16:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgIYOfc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Sep 2020 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgIYOfc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Sep 2020 10:35:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EF5C0613CE
        for <cgroups@vger.kernel.org>; Fri, 25 Sep 2020 07:35:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s14so1428183pju.1
        for <cgroups@vger.kernel.org>; Fri, 25 Sep 2020 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3sVDrl7nq71b7+Tl95Id30AEaStu5JjNu+SbInS86S8=;
        b=E55wmYy6/zrsq1xauJ75mYZUcCl/7T8kL0VfI5mCOUuYURZxcMOOCuqthu+IF2L+NV
         eVlWeUXhu5vEq18VjsiZrD8N8Pk0YBn3UJ20S0yUhwxU/3UiyJ/bTPgCZCRlHIKCtqf+
         4t22c3hKJyeQK7cv5zEt6qCepixo/cNSB3/qhci7vp34g73P5vhesH4X/NDeo6RfV2ub
         BIV8GJZkeuY5TiDZ/1rLHDCSOwqaT7mQ6eKLpRjVzo0yU2z/zidZBszbbUK642laboim
         qTAd7a0vjHf0JpTsjxT/CmJDVk2TnsS+rzCwxP9U/4bTuRRs+8MwUdkc8Raqtx1O3cZ2
         h+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3sVDrl7nq71b7+Tl95Id30AEaStu5JjNu+SbInS86S8=;
        b=kgEup5UTU7AkYYUJxz7WJOeFbycWDt1bGHmLm+SNtGqQvL1BgTU2T4bjP48okfDuYC
         3cpYqMocJ9PoQDWLSPf+X97rbdZJAg7FPMmarAnwc7juIZFXba3mw49IY8iS2nRl3S/J
         q8E8d7p45SGKgcmnS770tBZ/ujxxNwOudGDXQlpP5VPLBNG6NHW7iBKMM5qRpDbwghq8
         K+/k8EWBnA/vJhhDfIGRheZU2FY8zdrY7/ChLG21P+EKQMPyKogL1ld09tndYwRv0IKJ
         uVCi2WStKj3kXdgxYNjmu/ZePFHepTa4IuymKbd4bFF4WCUNjEJe4gzaNzKwAlcf26A0
         GTgw==
X-Gm-Message-State: AOAM531kHJUvMjH1HfkZkrhtfRMxSwFcfp+1TCOOSXwUjKgJlmUJZ2s9
        2R5Q3/NuIxR4DARMD7VHU98e1g==
X-Google-Smtp-Source: ABdhPJxxZ/jipQ6UmFyIc2cAtDZeTloKi918d+xUfqX+TxGNVI9NqJKGAzht2a4+S8FbMh21YYiD/w==
X-Received: by 2002:a17:90a:e984:: with SMTP id v4mr599004pjy.202.1601044531755;
        Fri, 25 Sep 2020 07:35:31 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r16sm2257501pjo.19.2020.09.25.07.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 07:35:31 -0700 (PDT)
Subject: Re: [PATCHSET for-5.10/block] iocost: improve debt forgiveness logic
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200918004456.593983-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a4baed8e-d3a5-3801-7f26-5c32f2931177@kernel.dk>
Date:   Fri, 25 Sep 2020 08:35:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918004456.593983-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/17/20 6:44 PM, Tejun Heo wrote:
> Hello,
> 
> Debt reduction logic was recently added by dda1315f1853 ("blk-iocost: halve
> debts if device stays idle"). While it was effective at avoiding
> pathological cases where some iocgs were kept delayed while the device was
> most idle, it wasn't very effective at addressing more complex conditions
> and could leave low priority cgroups unnecessarily harshly throttled under
> moderate load.

Applied, thanks.

-- 
Jens Axboe

