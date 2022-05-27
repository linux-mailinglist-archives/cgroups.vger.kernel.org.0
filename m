Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8721F536689
	for <lists+cgroups@lfdr.de>; Fri, 27 May 2022 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353078AbiE0RXv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 May 2022 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbiE0RXu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 May 2022 13:23:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B35313C0A2;
        Fri, 27 May 2022 10:23:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q18so4668899pln.12;
        Fri, 27 May 2022 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QNE+C9LvKf6o9OSSRIZZjYit2ACDgKSqp0cFlqRQUkA=;
        b=Ap9vNO/0kaxbQr1Vg/t3oTPnDrIe/ot0ObxfFazJtuLCid5VwVrE5SN+hTNy+tSwlh
         ul2W/6ur/9+D2cmH4pQfcdPOw8HEIpFq+6DC8s0G0qhWQzL4IWY5BXkLuFhKe6BFmS3C
         1Ap0CoVjGi5NXLGh3v/eT1h7/XpIxwL0ZiqL76/aXV2e0YJzrCd6ZlONbhgUgLs24Sn0
         vIJjto9cAaMbshQVQ+HqQyGs14NGdfPMLR9RXRipGkmLbnSX7HSHNJDHDlw4e6h9rKYw
         KbQkyb8s0k8mza2dkWOjnSYImUcQkkZsIGLtmPwEl9NLbDo0AR403M8wAZgYCW4yLrwb
         OaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=QNE+C9LvKf6o9OSSRIZZjYit2ACDgKSqp0cFlqRQUkA=;
        b=tYIVlld4fTF0W2d8obNutjAxxmrDgsptxD2Snlni5FE+o5rDi7rMW+dl9Vj/pHTqSJ
         /yTWTP1rXNh24I2wgzqgSi/2ypiN7avPtZBTuuos7izdAJ2qwcHPsY0tjlFEmNZgjGGD
         HTkDZp+SgrcG5I1I6otTnT6O0/LBfSdgbQ05eoN8uop6K5I8NqCu2iYLsth/atbUiOfe
         ZKaiDL9exnrONTR4f2bj0fMI/B6rYO6Aps53dEsAtFoZBQwirf7wVTOgTmkb7/XjCbLn
         A54E/tWT25eN7Sx5v19yg7NpTSQ7weCh0iPfRDBV9laNXe8npqQT5vcND0jEPzywZYVb
         pwzQ==
X-Gm-Message-State: AOAM531tKCtMOuSwUw0SJR6L2LUbsvrb0ftlstHnD7jQVVLUSBvE0KEf
        TqLqbECIOG6RJxfRaSS6S3Otj+09Rno=
X-Google-Smtp-Source: ABdhPJztcIM5jLzkkE+h5WG0QxVIkFzyKnQa6MjuoTuKxBxwXGiTJQBgopdAb8yKfd7xuzzeiM6RIw==
X-Received: by 2002:a17:902:e806:b0:163:6443:ec6a with SMTP id u6-20020a170902e80600b001636443ec6amr12431207plg.171.1653672229339;
        Fri, 27 May 2022 10:23:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:ac0e])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090a3fc300b001e270cc443dsm1868801pjm.46.2022.05.27.10.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 10:23:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 May 2022 07:23:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
Message-ID: <YpEJI7OZDVnxHRA8@slm.duckdns.org>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz>
 <Yo7KfEOz92kS2z5Y@blackbook>
 <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <904ef8af-13a5-e566-b760-74519f70fa62@linaro.org>
 <20220527165429.GJ11007@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220527165429.GJ11007@blackbody.suse.cz>
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

On Fri, May 27, 2022 at 06:54:29PM +0200, Michal Koutný wrote:
> Hello Tadeusz.
> 
> On Fri, May 27, 2022 at 09:39:20AM -0700, Tadeusz Struk <tadeusz.struk@linaro.org> wrote:
> > As far as I can see we are trying to test the same thing suggested by Tejun.
> > I just sent a test request to try this:
> > https://github.com/tstruk/linux/commit/master
> 
> Yup, I've added few more prints to get more fine-grained resolution.
> Also, I decided to use ftrace printk not to interfere with timing too
> much (due to the original race hypothesis).
> 
> > Let me know if you have any more tests to run and I will hold off until
> > you are done.
> 
> My latest attempt is [1] (tip 5500e05d82fd5b5db2203eedb3f786857d3ccbea).
> 
> So far, I'm not convinced, I extract the complete ftrace buffer from the
> syzbot runs, so I'm not drawing any conclusions from the traces I've
> got. I'm not going to continue today. You may have more luck with your
> plain printk (if it's just imbalance and it avoids printk locking
> sensitive paths).

At least for triaging, it may be easier to use bpftrace to attach kprobes to
the get/put functions with the right filter and record the kstack counts.

Thanks.

-- 
tejun
