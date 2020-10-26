Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4271E298EAB
	for <lists+cgroups@lfdr.de>; Mon, 26 Oct 2020 14:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780822AbgJZN6M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Oct 2020 09:58:12 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40697 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775160AbgJZN6L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Oct 2020 09:58:11 -0400
Received: by mail-il1-f193.google.com with SMTP id n5so8363541ile.7
        for <cgroups@vger.kernel.org>; Mon, 26 Oct 2020 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jszuR3zqMSYhTcL3FUWEd0lFc+5Piy/LuuN/X4w12ZE=;
        b=UlD2l9tJv9e7egQPf3vwasJKZ6rXr0MvOAppN+FYNHUSsOVJ4wViTv6XZYwfNWkmq5
         fiIwU8h6ppZ6HogWNMv9RlABvPE9gRUaaoeTYGd+ztltCWL8kQFiAcN0+WdLvxQqJTuv
         6lFC/it6ywbwaUXg3UEXACs2yxS1SJSYh0of0j8b9s09RFswgtjpY8yOXh1Dt7rSUhnG
         38KnV2lMNE0MZT6Q9Qpz3HU3k5APscM6Fa9FgNhLj8kfUekzFlF8jAmUwM7ePaMQY8eZ
         jKGQ7E+X77rdnKK2mGO2/OwLwpup1cnzqjNeDKaoUVfg7P/HOn2dchDnKrawUbgNcdNH
         oYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jszuR3zqMSYhTcL3FUWEd0lFc+5Piy/LuuN/X4w12ZE=;
        b=n4Un9jdXOapyzIRljlY/bsJbZ3DCyiCFzR3a+otcIjHKF966W7lUqm6B0Em5c01gIk
         Xnrhr3XXeSTHoLi6DdlQgTrbeocBrT0ee/yTqVyOiNjrI6G9BIpz3JJ+JdcAwWqSPiVi
         3coWrenYHT/HPa/DNJ0AUZWYkKWoY0h+7lwV0E5/XmBXy3dwBd2sNjxdKI+/ttaiLlO/
         vV7ZRwXY3Wm5tHDtnYRYL+nsiEj7oxmIfkZbVARQZp1R3Ig9esyGhmK4JpKwhuYyvX5x
         uiuIATTT0dIIYqgAEMrYOwi6/q02aJcaByPyc5ban8S0R2FN8jn+QSHUZY3JR3ydYN3q
         Bkow==
X-Gm-Message-State: AOAM531ojX4vMBALjvg1KavSLi8qvel4JTUKcGPlC5hEsgBgU/Kk7YvD
        P7wvD9WhwDXXH4CGBpf81vGFLg==
X-Google-Smtp-Source: ABdhPJz0uu+umKhKDU5pRoX0Dh2Hz1Fgeb/qCJVgwpCuOwrAlQO3vtL/fhm4ZUv16oHcFC8aMPOgKQ==
X-Received: by 2002:a05:6e02:ea8:: with SMTP id u8mr5329069ilj.305.1603720690125;
        Mon, 26 Oct 2020 06:58:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s85sm7121716ilk.41.2020.10.26.06.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 06:58:09 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Fixes to blkg_conf_prep
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, khazhy@google.com, kernel@collabora.com
References: <20201022205842.1739739-1-krisman@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <73a3223b-2a92-49ae-e985-13399d8bf86e@kernel.dk>
Date:   Mon, 26 Oct 2020 07:58:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201022205842.1739739-1-krisman@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/22/20 2:58 PM, Gabriel Krisman Bertazi wrote:
> Hi Tejun,
> 
> In addition to addressing your comments the previously submitted fix to
> pre-allocate the radix node on blkg_conf_prep, this series fixes a small
> memleak on the same function.

Applied, thanks.

-- 
Jens Axboe

