Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F0453B09C
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 02:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiFAXnP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 19:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiFAXnO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 19:43:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E05A189;
        Wed,  1 Jun 2022 16:43:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e11so3296308pfj.5;
        Wed, 01 Jun 2022 16:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7PESzE8t9Lz5OlcxB//4LK+p9oMKSM6zcC2n6BmadAw=;
        b=jHJn4C6EiJHA/wfbqAQg3eI1uA1ryOPpUfynKm2uBWrty9D4XBUkhXQsUOCu8Ikhwu
         iVYsfkSi/+o3cLOVcI5ZyKmBF7MxnXoGXarYCVp0tjZJi+p1jPoO32tClD0Br+10qT/l
         MNzpDLGps7NWAom3zY3tMYa+qyWKS8pf0lMnNEwwTFZrO/rFkAxMbpaeTR7OmACjNSB1
         IFDWyE6bhFvYaHyil6X1QfkkFo4k5n87TeCTA2uIf/Noxk1bQtApnZbci3+E7v58fL0m
         8Yec0B87XoSKOGKUALuX/BcsiU/15e/J7BvPuB7UjnR0Xxvk2nsD1fomvrZh21l6114g
         Wy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7PESzE8t9Lz5OlcxB//4LK+p9oMKSM6zcC2n6BmadAw=;
        b=IgRt3iFpPidpdrvzBisS9bMgT2oDE52Z5Tmr/Vj8RO+vw1x/JUTK1LBloCtIEdNfbf
         eGIuArsOT1qgfDfaFaqLrbMTp9hIUtIGMzxxSMr2jzLR0uQMkTfPdknY1awW+b+IBK+d
         0/OsbmA6ave2r1ijesgB899T/36zvbyToaSAlaJLI2bbYckZZF8TRDFagPuQWWxxpnT+
         RQaJVPgs7Q9H7V6euU9QKVXEU0RFTblXlk55X0xyEYG3lsTreVT5iBECVstf4My+HSXw
         u5sEeu1uyXnRLr0APkuLa66X8UqekxJEY7jJ6aPLA1tb9yYAPDQE+wzUymARdqZdYnY7
         FWQA==
X-Gm-Message-State: AOAM531p3ZKFGwFIGntcJB7OpYxQS3x/1Lm2kx70yNOuG7/wr+qbka+O
        vT6MY3NYhn+F6BQn8DFy68cavpGRPqo=
X-Google-Smtp-Source: ABdhPJye+RZNxgushJU8BG8WEN8YymGWWsZIKZp0wqBnskqEG3KFqQUSoBBBATTNWUCkbMc9CKZClQ==
X-Received: by 2002:a05:6a00:1815:b0:518:9681:44ee with SMTP id y21-20020a056a00181500b00518968144eemr2058179pfa.15.1654126992852;
        Wed, 01 Jun 2022 16:43:12 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h69-20020a628348000000b0050dc7628138sm2106303pfe.18.2022.06.01.16.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 16:43:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Jun 2022 13:43:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
Message-ID: <Ypf5jpI7dSmpi4W0@slm.duckdns.org>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz>
 <Yo7KfEOz92kS2z5Y@blackbook>
 <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
 <Ypf0VnKUMiuRgZqT@slm.duckdns.org>
 <1fb4d8d7-ccc0-b020-715e-38c2dfd94c23@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb4d8d7-ccc0-b020-715e-38c2dfd94c23@linaro.org>
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

On Wed, Jun 01, 2022 at 04:37:17PM -0700, Tadeusz Struk wrote:
> Yes, but as far as I can see the percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn)
> doesn't change the value of the refcnt, it just causes the css_killed_ref_fn() to be called

Yeah, the base ref is special for percpu_ref.

> on it. Only css_get() & css_put() modify the refcnt value.
> And for the "free the thing" the css_killed_work_fn() does that.
> It calls offline_css(css) and css_put(css) for the whole css hierarchy.

Yeah, the freeing path depends on the css_put(css) invoking css_release()
which schedules the work item which actually frees. Am I misunderstanding
something here?

Thanks.

-- 
tejun
