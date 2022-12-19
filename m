Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4401B65112C
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 18:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiLSRV4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Dec 2022 12:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiLSRVx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Dec 2022 12:21:53 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC15C1B
        for <cgroups@vger.kernel.org>; Mon, 19 Dec 2022 09:21:52 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so14529470pjb.0
        for <cgroups@vger.kernel.org>; Mon, 19 Dec 2022 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSN/Hlv/5HI+5br/xw+yoZ8A3PY4ltv42IV6oSp+bf4=;
        b=GU3Iqx7TE/nIcLU9/rUE+9n0oR0xwjOzb98XevQ/KERqjPTJ9LQClvSxkPYnJaszYx
         0wBPIsZ4KiGyGuf8OFpVI7OCiVDaprpOQrNBIqYk27NgibTsReLANi9P5gtu+Kyeylsq
         oeu1AIovcst6uT1EqIDmFLZtouMnUslUbvhYcfnB8ugjacfkoglICWeKjTrKi6Q2Mp/L
         o6qUGgYK05xLDL9t65FeDh9ZlGMaxQmTz53/scE4MfDDq/1XsFUN0Q23m/f5XKnOfMoa
         wfb1hV5TdfezRUEflgIvTdZ53ndH1zUZmxY8eldsGsCnSLqa8hYOvwMx1KMYBkfXkmak
         /erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSN/Hlv/5HI+5br/xw+yoZ8A3PY4ltv42IV6oSp+bf4=;
        b=CruBXlKU2wjI8G8qqqxohlhf47GDxD1jenzwpxjVYn1/q1R6+OALNTCC2Q5EHN5HoN
         UNUOFIHCmZ48SDPgZydY5pj6Olrf+r/23BpB913FMrx1830t5A1cdCHpV83xicxejN3R
         JlF0hsXF9LBZ4+3e7MDGWQMgmNJNlwXaaJxNQA3sQHavg89NTIQwb2fvfdbmOeHayqF9
         g02/YsrjT18iK4bWzug3+QuuKxwKjFtRE92AeUdOYQLmIXCJjvUhGxcOykBuXHCWA8Zn
         05syrnRPl6vILRbiksJi8J9tMp0afW6iHVpiInueTCYnoW3X1FRUgeu8zkihWdN29Gia
         x2zQ==
X-Gm-Message-State: ANoB5pnnlYbyvIkxeohe2/zOFZjW7DlhxEM/YSKGX2Z/+20FP6l6xQiV
        7e91X+YqhsdDPyabwiIHWs1C/tDagOZfAA==
X-Google-Smtp-Source: AA0mqf7Ukj3aS4cP9jwhrTsVBFHeA4mbn5ea+1U93jTCb08q8eqxx8xqMDtmhFrWF1rGFesgG7va3g==
X-Received: by 2002:a17:90a:d594:b0:219:ed0b:f11a with SMTP id v20-20020a17090ad59400b00219ed0bf11amr44416140pju.8.1671470511663;
        Mon, 19 Dec 2022 09:21:51 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ne18-20020a17090b375200b00219f8eb271fsm9868621pjb.5.2022.12.19.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 09:21:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 19 Dec 2022 07:21:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Nikolay Borisov <nikolay.borisov@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, paul@paul-moore.com, kernel@openvz.org
Subject: Re: [PATCH 0/2] Defer checking wildcard exceptions to parent
Message-ID: <Y6CdrYdbiBnUSxQi@slm.duckdns.org>
References: <20221219114052.1582992-1-nikolay.borisov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219114052.1582992-1-nikolay.borisov@virtuozzo.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Nikolay.

On Mon, Dec 19, 2022 at 01:40:50PM +0200, Nikolay Borisov wrote:
> The situation I described is how systemd functions, in particular when setting up
> a devcg for a service it would first disable all devices, then add a bunch of
> well-known characters devices and finally evaluate the respective cgroup-related
> directives in the service file, in particular that's how systemd is being run.

I agree that this would have been the right thing to do in the first place.
That said, the behavior has been like this since the beginning and it's
difficult to rule out there may be users that depend on the current behavior
of a child config being rejected if it contains anything beyond the
parent's.

> Without this series systemd-udevd service ends up in a cgroup whose devices.list
> contains:
>
...
> 
> But its .service file also instructs it to add 'b *:* rwm' and 'c *:* rwm'. The
> parent cg in turn contains:
> 
...
> 
> In this case we'd want wildcard exceptions in the child to match any of the
> exceptions in the parent.

and as your example illustrates users already implemented the needed
semantics on top of the existing interface or moved to cgroup2.

I'm not sure about introducing a behavior change this drastic now when users
would expect stability than anything else.

Thanks.

-- 
tejun
