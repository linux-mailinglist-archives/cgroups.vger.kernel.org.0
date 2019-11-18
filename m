Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB42100871
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 16:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfKRPlR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Nov 2019 10:41:17 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43183 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfKRPlR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Nov 2019 10:41:17 -0500
Received: by mail-io1-f68.google.com with SMTP id r2so14094413iot.10
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2019 07:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LDK9yK9BoIJXiRshGH8S+ARb//vvA/0NHK9tQB/EqPk=;
        b=JaQ3lkdxJbg8bC1c3jS+KwvIPC4OYHwwfxOOr83yS4U4QDzFNnWNlZ/p8PuJ96np2E
         fSAKxEDc8Nlw46j0x8sDTkmy8rEIthr/WFem2d8bAl0iNj18msLAPp9+Qqw8SvjrYFOj
         3EJP2rizmnWjpUQ81QDQLHav2Tp5HVA4u81MwCU4l9mmA08xnqINakg2qQ0Qqif/jPDU
         cj76eJwfOZnRj3nWeBGiV/PEuiL0fSFQfPs36u/4sn+YKAJg5MIM0MMYKTeugndAPPka
         ajIMC8PlwEyo22uO2Ji9NNlBpygJnk5UjX4ca26Yx50OfsMWk84dbtjiEcKRS6BQEBNE
         yt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LDK9yK9BoIJXiRshGH8S+ARb//vvA/0NHK9tQB/EqPk=;
        b=CaBvja2q167P+MtnzU9fsAGlFgmyz3PJy5Ar/ql+NLH6Bvp9Ja55si3J42fRQNK2Xb
         jTq8N4jn57t06xmeYE+HjqyWk5xy78cYcVQGt/TOx0neB5FM0N4nkCaYXPI8oXemGbaa
         Ohe/R0wCGAw+cBZ+BR5jBF2OnVOVMEdM4q/6MiZSju7aNL2z9S1t33A71MnInqrUuv84
         bx7Ohjbjk6U/9ARQCnV1ILt2MBiBMczvD3JV+D/HdMsppF1H3q/VA37koIh2ipQba9b6
         ZrwvHKi+kolr8a4tdURYIJZY3lKfhx61FS94gO9zyAzkoy+Q1Ph3hl1JK2PnimypgKu2
         M+QA==
X-Gm-Message-State: APjAAAWyVfNg4yX5TrUf8txSkXDxnglaO/Jd8/UoEBt5xBuhr/WyDsiN
        b1GEg3W1weOLLj8O0OV27u5ywA==
X-Google-Smtp-Source: APXvYqwof3l/MsVfP7ktJ3h+n1HCG5pvVXBQdOFvhVIS26ekBuLo1YKhPDa/JlQ2jH5waDFiOTh3+Q==
X-Received: by 2002:a6b:c0c7:: with SMTP id q190mr9712406iof.256.1574091676102;
        Mon, 18 Nov 2019 07:41:16 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u6sm4612045ilm.22.2019.11.18.07.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 07:41:15 -0800 (PST)
Subject: Re: [PATCH block/for-next] blk-cgroup: cgroup_rstat_updated()
 shouldn't be called on cgroup1
To:     Tejun Heo <tj@kernel.org>
Cc:     Faiz Abbas <faiz_abbas@ti.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, kernel-team@fb.com,
        Dan Schatzberg <dschatzberg@fb.com>, Daniel Xu <dlxu@fb.com>
References: <20191107191804.3735303-1-tj@kernel.org>
 <20191107191804.3735303-6-tj@kernel.org>
 <cd3ebcee-6819-a09b-aeba-de6817f32cde@ti.com>
 <20191113163501.GI4163745@devbig004.ftw2.facebook.com>
 <20191114223128.GM4163745@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <091022e8-e6a1-178d-80cd-b2a070d3519f@kernel.dk>
Date:   Mon, 18 Nov 2019 08:41:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114223128.GM4163745@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/14/19 3:31 PM, Tejun Heo wrote:
> Currently, cgroup rstat is supported only on cgroup2 hierarchy and
> rstat functions shouldn't be called on cgroup1 cgroups.  While
> converting blk-cgroup core statistics to rstat, f73316482977
> ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
> accidentally ended up calling cgroup_rstat_updated() on cgroup1
> cgroups causing crashes.
> 
> Longer term, we probably should add cgroup1 support to rstat but for
> now let's mask the call directly.

Applied, thanks.

-- 
Jens Axboe

