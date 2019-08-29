Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F12E7A0FEE
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 05:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfH2D3G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Aug 2019 23:29:06 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:43129 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfH2D3E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Aug 2019 23:29:04 -0400
Received: by mail-pl1-f180.google.com with SMTP id 4so900874pld.10
        for <cgroups@vger.kernel.org>; Wed, 28 Aug 2019 20:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JGxbE50uXwCgfhAfE1eTU8tNsVQiLS6htVfulohzZj4=;
        b=YcVaHG7J8kEUDEEpnsah1aC33aFF/zVr9WtxqWBS/dVq90U/A5AgzuMSwi522I98nE
         JO8rA9dtet4C9wMyT2ZBAADep7t6cOkCV8+4UOo6nfksXdT4Rd6v/g4xKys4wjTQvkAG
         hhvxC14TXxXJauZWxqVQU8IzKF66W5niRk7fIdp8Ix9De6qGWEOhuAMoe6kKLhTxxf6t
         TtHfwstOlHFEUJr66LCpaRJWxc52yQZRenzaX/zb/M98dxweJf6eqPo1jJ1hhg+UCw3G
         Saes9+wAsSIoIkuN0nuZqPYVFo3jt6AceCpIOvGpk/p1tGh3dX2TQzyPA8xsqopw8kJA
         0RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JGxbE50uXwCgfhAfE1eTU8tNsVQiLS6htVfulohzZj4=;
        b=kp2HjwePcEcjLWMKUgFzQmnwRNCeLpnsfA7Qpgx7PdNr+YdP+TMn42wonAZC2qafqR
         4Z/DGlsOTaFYo9YKjm1G/LmSg/S9xqjRDxEs5k7p4/+0vXeEBqa7q4zwtyszzf9P06TU
         t1W8FTQXfKTk1jDTCP7A7eyrGBfa1COu8WH3PcPSaFUOqz6g0c6adV5jf2wxefZSUlys
         4WXNZfZDKgi4JgW+uiHmqb19KyUFaqzLBV3EYkEe84Iz6R69/K6rRpAlY01g1kb8PvV3
         WoLYgPTONILD5wzbpEuPZ63oOHzilDJFrzmh2J4EC+jGIJ/8skXxi12qPf4OHpkDVnJm
         wP+g==
X-Gm-Message-State: APjAAAVjCCq8v7x2SQT35ZE+13hVhD0s4aWhMTU6nmMWrNcC5xlBKEHU
        duaCH9FPgJc9aAL/lGpAFDsfOWTXvj4ljg==
X-Google-Smtp-Source: APXvYqz+BYvMbypoZoZy80tENbu+/0EycC793rpafApGirMRqvp3VXLwhMl4+uoaKwWdC97/mFhG0w==
X-Received: by 2002:a17:902:8543:: with SMTP id d3mr7863103plo.80.1567049343394;
        Wed, 28 Aug 2019 20:29:03 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 136sm859015pfz.123.2019.08.28.20.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 20:29:02 -0700 (PDT)
Subject: Re: [PATCHSET v3 block/for-linus] IO cost model based work-conserving
 porportional controller
To:     Tejun Heo <tj@kernel.org>, newella@fb.com, clm@fb.com,
        josef@toxicpanda.com, dennisz@fb.com, lizefan@huawei.com,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
References: <20190828220600.2527417-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f48b98fa-b33e-b3d3-2657-04f599e710fd@kernel.dk>
Date:   Wed, 28 Aug 2019 21:29:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828220600.2527417-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/28/19 4:05 PM, Tejun Heo wrote:
> Changes from v2[2]:
> 
> * Fixed a divide-by-zero bug in current_hweight().
> 
> * pre_start_time and friends renamed to alloc_time and now has its own
>    CONFIG option which is selected by IOCOST.

This looks fine to me now, I've queued it up for 5.4.

-- 
Jens Axboe

