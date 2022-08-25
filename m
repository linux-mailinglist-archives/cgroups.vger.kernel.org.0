Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504915A189B
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 20:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiHYSQ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 14:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243460AbiHYSQm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 14:16:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C3EBD1FD;
        Thu, 25 Aug 2022 11:15:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso5785323pjk.0;
        Thu, 25 Aug 2022 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=fcKBwzQ+3FvK05e8vJPVdEnteLULk8JgW8p1pB9U+CI=;
        b=TCOluU41yS0PIH//NJHewas8S7wRDMNMpr/FhfdfFjPVI1OJTelfGc75wL+HbxGtYw
         qytzyT5kAvTVBteRm8wHc5E25sn9+dH9JCzPNsMr73279vyf+7/pTZY6YH276OmkzNjN
         iElud98mzag7VV76DPmVTZET+w6ftAKVSrX9oEOpnnlvY5iTxNyMKI4FqKd6Y9RJYWRl
         yaOfDsKM22jhDLZxX6KOXBjRO/hBeN/WZ2ZMFLsqglTyIm+1nSSkbRYv8c/yun9DAJJh
         WqttI/0IE8EWDAAiiF91zwBeIW4Jhcqjy0lx9ZTekF5fSSuRE8/X8f2u/VN/rGcT4+c2
         PNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=fcKBwzQ+3FvK05e8vJPVdEnteLULk8JgW8p1pB9U+CI=;
        b=xhRnj6LOcfFOHgot6teeVoVCaRzW/J4WceZraoGGm3Yk1d0SMKEjq5vx41yOlI9pHg
         hQeQgXm1EnvhM3KZTFcUsaLW/8RmEaTPYMnIFQkInfx9avd9Z4EO0oZFDFnxL5xukawL
         LZwmLu6KldDCpP8W5A5A3XtMOtn4UFQoDXRONdcOmWPS0Zm6lqONc+ZiFo8AeyY1K0pX
         mP82SesGe3RcuEbM1H99cEQkYwUhD5IIemoXeMYZ8OqT8E3HguFk4fToNt1+20m5SVCs
         e2XgiqpCXBn2F9XmpEBHyf7XxgCce5r+nHh/C9NdulRaTEXG90b8CdMQkrcqEiVbQZfX
         Hh9A==
X-Gm-Message-State: ACgBeo1DsIYMcRVkMkt8AWuy8wshcUwcELTqMFCot+vhhaKxKc3gJm7f
        F/dN5/I3oYxnyCY6zxj60hE=
X-Google-Smtp-Source: AA6agR42sCFi5m76EhmM46dr9XtMi4BgiG1jbj/a53PbpcP2U/WiONaOHS42yTBkALMuUxcVuqjfMg==
X-Received: by 2002:a17:902:694a:b0:16e:e270:1f84 with SMTP id k10-20020a170902694a00b0016ee2701f84mr207011plt.89.1661451349742;
        Thu, 25 Aug 2022 11:15:49 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903024f00b0015e8d4eb1d7sm15158837plh.33.2022.08.25.11.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:15:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 25 Aug 2022 08:15:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, mkoutny@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v8 1/4] blk-throttle: fix that io throttle can only work
 for single bio
Message-ID: <Ywe8Uz4Gy6j/EsUg@slm.duckdns.org>
References: <20220823033130.874230-1-yukuai1@huaweicloud.com>
 <20220823033130.874230-2-yukuai1@huaweicloud.com>
 <YwUXTL+8E/sPcEUB@slm.duckdns.org>
 <73c72914-e27d-b261-e040-2dd31e8a6b9f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c72914-e27d-b261-e040-2dd31e8a6b9f@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 24, 2022 at 09:15:32AM +0800, Yu Kuai wrote:
> This patch actually set two flags when bio is throttled and
> dispatched, and only iops flag is cleared after the original bio is
> split. If only one flag can be used, the way that I come up with is
> that let iops limit become default, which means bio is always counted
> for iops limit each time blk_throtl_bio() is called. I'm not quite
> sure yet if iops limit can be counted excessively this way in some
> special scenario...

I don't think we have a path where we clone and re-submit other than
splitting. What do you think about renaming the flag to BIO_BPS_THROTTLED
and just assuming that IOPS is always applied?

Thanks.

-- 
tejun
