Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCCE628BFE
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 23:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiKNWUD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 17:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiKNWTl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 17:19:41 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0463BDF09;
        Mon, 14 Nov 2022 14:19:38 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k15so12410291pfg.2;
        Mon, 14 Nov 2022 14:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CFeFkvZOn3+ucUALvR/U14w4izEUCDR2kTDtlNxQCE=;
        b=cqIHEjSRzp/QzDWAkHso5UgqwlPuL25EWfel0ecGsIWWkc1m7HAJfPPBedKaoz0+je
         k6s7CRBqQXAET+Kvi+Z+gLXoE03ArA6qG2oHeC9KOc+ww4Oh4d0SyCyuJ0kh4rak9b7U
         TXXBZJ1ztH2WTht20jENgPSSms0m1Rd0Z8CKk63rsUHvzH18S9yzYWrXL5YiTk0Mhm4W
         wBblEuTPc6cKqmnCI/J9EdsgAYDgoHR4sFVxva8QarsDn8xTTjMV5638S9kSrfXw8sVu
         1y9Mziq9aJ0MDGurItuvWd1M6O4Na7VgQ4J6DZCoIjcm6xAF5ihIla/RHz098LTRchvq
         8QAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CFeFkvZOn3+ucUALvR/U14w4izEUCDR2kTDtlNxQCE=;
        b=drmjalACINc24JuaenTm5DfEGix4NTHssVT3RtGAW/0Bay8iF4uiwr2LzoJmPwUfRm
         78QtBiWDHHL3y2ZlUGb2VrAvELG5/HQQnL6P6CQ+QUYNWM+z9T2J3f1IiGDd+IRKgMHd
         Qtps0YvGC7g8IUkHAtYZKL/NUTd4D4mbZfvaFrav/nbsdxWeMIiwl4piyx6c2jxn1Nm7
         QyhxdRBtiwfr4N8liOayGkFrJBze6hTr6SVUjyjjPVf2ztTH7+CkjtxK9z6j173Fl4Ek
         kIKJzeifGbgYcIvxcqNyQ9A7cwlRZokeY2dSeaBE0s2oLpFPzQHoy3W+qKzfQaDPUd6O
         IcWw==
X-Gm-Message-State: ANoB5pnmhNpaeVQ//+sGBCWIEufwju1XJpydm2RSgnNdWd3R0f0cud5a
        b+2UXwlrwMypR1m2XjyPQgg=
X-Google-Smtp-Source: AA0mqf4dXYgEWcoeonCxAY5cqWOVWvFZg735xqvo9oZWd73PR4cA/Tb8XtPptNl3MB81ZK0fFHqKxw==
X-Received: by 2002:a63:1c14:0:b0:45f:beda:4116 with SMTP id c20-20020a631c14000000b0045fbeda4116mr13462010pgc.618.1668464377397;
        Mon, 14 Nov 2022 14:19:37 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e80300b00172e19c5f8bsm8113697plg.168.2022.11.14.14.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:19:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 12:19:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, zhiquan1.li@intel.com
Subject: Re: [PATCH 18/26] cgroup/misc: Expose root_misc
Message-ID: <Y3K+94YYVbTg2a8P@slm.duckdns.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-19-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111183532.3676646-19-kristen@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 11, 2022 at 10:35:23AM -0800, Kristen Carlson Accardi wrote:
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index 8f1b7b6cb81d..b79c78378f17 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -59,6 +59,7 @@ struct misc_cg {
>  	struct misc_res res[MISC_CG_RES_TYPES];
>  };
>  
> +struct misc_cg *root_misc(void);

This is too generic a name to expose globally. Can we do sth like
cgrp_misc_root()?

Thanks.

-- 
tejun
