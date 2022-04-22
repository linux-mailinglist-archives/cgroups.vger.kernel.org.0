Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940FA50BBEA
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449572AbiDVPqA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449506AbiDVPpa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 11:45:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6EA5B3C2;
        Fri, 22 Apr 2022 08:42:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s14so11651907plk.8;
        Fri, 22 Apr 2022 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/2bXBH57zZDvmeIOYDk/m7NyaBAKN+vWWjfrVhEZ7T4=;
        b=XYZOLh+Jv2kL2sx884zx4C5eFWyZUuKY38ML9XvAYhNcR9BREu4ndvKecAC8kiH8Wl
         2v8yd4kPP2gu4bBvSJJYHpMRWaZdWMCPawASUwvIYLt/36hDOsoQF6/PRGnoA/fP3+Iy
         OdYf/Am/17PxHTlnZSv3KbSRM9TsczBeb1wQS6jyeQwBOuRzRhaolF58FR4l9A1SPpSs
         HkM3GxADfbMO/Zvs8ImLLAeCMjyTOUQSJdFg27FdWbQ+EuDUKbiREIqdpGpAdH81y42c
         dVVAZmsCS7qchIwgGY0c3HnDxcg2FfvolA13AyZ8voskHxh/DdCWa9uIdpnjrvxytLup
         fQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/2bXBH57zZDvmeIOYDk/m7NyaBAKN+vWWjfrVhEZ7T4=;
        b=wsZc+GM2UzLy55ReM0h1QJOD4WO38nkrn4j7DyMVTYJMtFMTmfab+lJGNrXEUB1Us2
         AsF0bTmWBXv0ol/wpYmI2kikZvjavVDtp/NrOmVKmT2uJgq2XTPL/ZMYzCU3qZG8CR9H
         nfMz5vhVyHooVvBqk6v3EWOZZpxG4Qe3fD2FJ+2VSOmxX4xntrEaOWbuqAZ5CM0vt60L
         WGauzYn2Gac9BYcViOzW3gt+NNUP2OZMdp4CiQepR6MkJT1QE+OlILtCzk1zWMpAXjV9
         bqqMoxdzZM2MLjexRpk2kB6ynjuxSOg19OwpQrLJv0rXgegz0zrXtOCLU1Omfq0s7NLK
         efoQ==
X-Gm-Message-State: AOAM531HRe4YVRJUTMEB8Rjj8ncsaQKsrDdNaHQ/IK6ANkvyZphpkf3k
        UlnxzlN3+rtvklwD9hDpD9Y=
X-Google-Smtp-Source: ABdhPJxxn+CbIFWzfwls+DC0iuC84aNWB0fSRIoYKEF+syIzU+vM8K0HoUfp8xLLZbd6xF64bDs7kQ==
X-Received: by 2002:a17:90b:4c45:b0:1d2:acdc:71d4 with SMTP id np5-20020a17090b4c4500b001d2acdc71d4mr16900643pjb.39.1650642153919;
        Fri, 22 Apr 2022 08:42:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b5ae])
        by smtp.gmail.com with ESMTPSA id y68-20020a623247000000b0050acc1def3csm3032102pfy.203.2022.04.22.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:42:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Apr 2022 05:42:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: Re: make the blkcg and blkcg structures private
Message-ID: <YmLM5/1+VH5mdQ/o@slm.duckdns.org>
References: <20220420042723.1010598-1-hch@lst.de>
 <YmHQS1pyIglK+gfS@slm.duckdns.org>
 <20220422042318.GA9977@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422042318.GA9977@lst.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Apr 22, 2022 at 06:23:18AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 21, 2022 at 11:44:43AM -1000, Tejun Heo wrote:
> > The patches look all good to me and I'm not against making things more
> > private but can you elaborate on the rationale a bit more? By and large, we
> > have never been shy about putting things in the headers if there's *any*
> > (perceived) gain to be made from doing so, or even just as a way to pick the
> > locations for different things - type defs go on header and so on. Most of
> > the inlines and [un]likely's that we have are rather silly with modern
> > compilers with global optimizations, so it does make sense to get tidier,
> > but if that's the rationale, mentioning that in the commit message, even
> > briefly, would be great - ie. it should explain the benefits of adding these
> > few accessors to keep the definition private.
> 
> Mostly to help me understand the code :)  between all the moving to
> and from the css struture it is a bit of a mess, and limiting the scope
> that deals with the structures greatly helps with that.

Hahaha, yeah, fair enough. I don't see a reason to not apply the patchset
given that the code is better organized and easier to follow afterewards.
For the series,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
