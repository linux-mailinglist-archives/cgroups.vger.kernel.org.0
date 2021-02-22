Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBC1321D28
	for <lists+cgroups@lfdr.de>; Mon, 22 Feb 2021 17:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhBVQiW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Feb 2021 11:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhBVQiR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Feb 2021 11:38:17 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A24EC061793
        for <cgroups@vger.kernel.org>; Mon, 22 Feb 2021 08:36:56 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id s6so12546393otk.4
        for <cgroups@vger.kernel.org>; Mon, 22 Feb 2021 08:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CQtzj2ET+OspvcT7VasFUJh31XI2DgueE7K7chQefu0=;
        b=JgIAcXbmqnUtAzeQggrQMFDw+iRD7712f5b6XLlsNpGFq/2OH71ZR8eVPcYSvV8O9Z
         Q4ZFhr/HY3qIL2VVw5am2ZXMqQjcHv6oQm57icBzxpF2r/H6pUN28Ic0UVcMNAWR0oM3
         Nk4pk+06r39DoxUQo5VbU8V6VX0ewSDT/6fu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CQtzj2ET+OspvcT7VasFUJh31XI2DgueE7K7chQefu0=;
        b=Z585Fqk8a0xhIwOvdBoarEcrKKaLdfoPX+Uj60bQcKQqfWJuJLXUwfbjnt0HiBDLFH
         Nrc8tLooOY15ZPP1mGH2cQB5QvRAsCfW4r07JYutK4wI3eWozbFjTL4VIp/b8W/XsHA5
         Uy7cH5oW+Eu3ck++S+HiLIHGJGIzv7UJTpyEpojC5F3Soge4G5gvPZkcyRODocLbA0K5
         c45lO4IHorouj6IOeZG1ll39812srScGrU+3w14m0KQ7Zh/2VcAG7I4duNrvZfEjjkvZ
         LRi2wyem0vmGdpWVCfxZgJwVix//L3HRnosqUYLKvCHif4eUZ6oJOBp3f+q64nlCpjMm
         8lXw==
X-Gm-Message-State: AOAM532s1Ag+jgz/PNKjUKq6xGkoYhPiwJ2fe7KKKBXcT6dRUyjAZumV
        /nrVI2GeP9+kFut27mq89GZNLg==
X-Google-Smtp-Source: ABdhPJyA692d/UkhfnySsVsus41uILuIidqyduT1DxwFO8wUlVI27VDOIjP5WOhWxUUsjwOOYq7M6Q==
X-Received: by 2002:a05:6830:314d:: with SMTP id c13mr16134049ots.124.1614011814286;
        Mon, 22 Feb 2021 08:36:54 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 7sm3712035oth.38.2021.02.22.08.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 08:36:53 -0800 (PST)
Subject: Re: [PATCH 00/20] Manual replacement of all strlcpy in favor of
 strscpy
To:     Romain Perier <romain.perier@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jessica Yu <jeyu@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     cgroups@vger.kernel.org, linux-crypto@vger.kernel.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-integrity@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-hwmon@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210222151231.22572-1-romain.perier@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <936bcf5e-2006-7643-7804-9efa318b3e2b@linuxfoundation.org>
Date:   Mon, 22 Feb 2021 09:36:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/22/21 8:12 AM, Romain Perier wrote:
> strlcpy() copy a C-String into a sized buffer, the result is always a
> valid NULL-terminated that fits in the buffer, howerver it has severals
> issues. It reads the source buffer first, which is dangerous if it is non
> NULL-terminated or if the corresponding buffer is unbounded. Its safe
> replacement is strscpy(), as suggested in the deprecated interface [1].
> 
> We plan to make this contribution in two steps:
> - Firsly all cases of strlcpy's return value are manually replaced by the
>    corresponding calls of strscpy() with the new handling of the return
>    value (as the return code is different in case of error).
> - Then all other cases are automatically replaced by using coccinelle.
> 

Cool. A quick check shows me 1031 strscpy() calls with no return
checks. All or some of these probably need to be reviewed and add
return checks. Is this something that is in the plan to address as
part of this work?

thanks,
-- Shuah
