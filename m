Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91853ACE0
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 20:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiFASfM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 14:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiFASfL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 14:35:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671ADAFB17;
        Wed,  1 Jun 2022 11:35:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j7so2805067pjn.4;
        Wed, 01 Jun 2022 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FbzMdSE++Z3RcXoQgdeDtp4CIVVd7ZyrnuvRlBLaN9s=;
        b=RM/ZC+I4clYsfGPoYtmleL23CkhR6fkmtFdMPocpJdCQ/fRijq0Gz/UQ6M/3cmu6fc
         2iq1fRmrtcDGQZfsiU5Ov2fuA6/NDPGWHd3wSCJQlWYY33jsCV8i0TBI7XqO8wgrdx3C
         5qI5Z3XBUvHUuz05gub26ahC326zTmvkrvXm8747qNaGDZDJ8/NJ9UIXcSL1Ppy3AlmX
         UOVCGloFj8sSfnTnAfwgIurNhDbA6VkX33crrvzxiCIz+97I8n3xGbarwxKRJiDBZNOi
         JmiUil/rY6lXODBU77MA0G7kTTJTcK0P+i553D/qiVJuoDwMoz20Uxm6qN62fOXEa35o
         QNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FbzMdSE++Z3RcXoQgdeDtp4CIVVd7ZyrnuvRlBLaN9s=;
        b=Rc0cCRe6fg7t6XZl/CBGL6QtZ5n6mMwB/6W+YEw+xKzERQ9dH5RgymposkNPqnoJ4O
         MoFZEtmmnTGUGz8oM1JTE5VY3kqPeSPr/yIEBsJwVmL3lHIid1ZQ/AAwSJba9rxo5ISh
         kwutnQpNwo5VHlOrq98HHc9mtle84M8pk8RkoSMi9SCmbB0aFslrjV/P7NrT/TFoeDHU
         NdEcAGG6/U90mIxcOVTgwyjWaxLq++GABEOw/tit+dfYiK4gJKu5hQUhIt33oUeRks56
         QQD19N5N4AaxpwMbMPGklmTUVa4SR3h/BOnfY/Y42YllzOUhsjlD7x2kgpZZrW7pOu/K
         sDxw==
X-Gm-Message-State: AOAM5332wGtfOnsBlzJH9S9IAsYaDYuwNIKevQGXY+qpmfptGqzzYkdT
        b8RwbYEmDr1U22QNfp+2xHE=
X-Google-Smtp-Source: ABdhPJyIMdQpZ2Up1ftUGpePXDZvD5dhGRI4u/BNJWPadl94ohUBjIlaXm+mMXTlim4SUQAoQ39osQ==
X-Received: by 2002:a17:90b:38cc:b0:1e0:1c6f:d3e3 with SMTP id nn12-20020a17090b38cc00b001e01c6fd3e3mr35601675pjb.86.1654108507089;
        Wed, 01 Jun 2022 11:35:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090331cd00b00163daef3dc2sm1863118ple.84.2022.06.01.11.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 11:35:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Jun 2022 08:35:04 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 2/2] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <YpexWFptr/l2Y0rU@slm.duckdns.org>
References: <20220601165324.60892-1-longman@redhat.com>
 <20220601165324.60892-2-longman@redhat.com>
 <YpemVpvaPomwH7mt@slm.duckdns.org>
 <ca091a5c-4ae1-e973-403e-4086d4527102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca091a5c-4ae1-e973-403e-4086d4527102@redhat.com>
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

Hello,

On Wed, Jun 01, 2022 at 02:15:46PM -0400, Waiman Long wrote:
> It was mentioned in the commit log, but I will add a comment to repeat that.
> It is because lnode.next is used as a flag to indicate its presence in the
> lockless list. By default, the first one that go into the lockless list will
> have a NULL value in its next pointer. So I have to put a sentinel node that
> to make sure that the next pointer is always non-NULL.

Oh yeah, I noticed that in the commit log, but I think it really warrants an
inline comment.

> > > + * The retrieved blkg_iostat_set is immediately marked as not in the
> > > + * lockless list by clearing its node->next pointer. It could be put
> > > + * back into the list by a parallel update before the iostat's are
> > > + * finally flushed. So being in the list doesn't always mean it has new
> > > + * iostat's to be flushed.
> > > + */
> > Isn't the above true for any sort of mechanism which tracking pending state?
> > You gotta clear the pending state before consuming so that you don't miss
> > the events which happen while data is being consumed.
> 
> That is true. I was about thinking what race conditions can happen with
> these changes. The above comment is for the race that can happen which is
> benign. I am remove it if you think it is necessary.

I don't have too strong an opinion. It just felt a bit disproportionate for
it to be sticking out like that. Maybe toning it down a little bit would
help?

> > > +	/*
> > > +	 * No RCU protection is needed as it is assumed that blkg_iostat_set's
> > > +	 * in the percpu lockless list won't go away until the flush is done.
> > > +	 */
> > Can you please elaborate on why this is safe?
> 
> You are right that the comment is probably not quite right. I will put the
> rcu_read_lock/unlock() back in. However, we don't have a rcu iterator for
> the lockless list. On the other hand, blkcg_rstat_flush() is now called with
> irq disabled. So rcu_read_lock() is not technically needed.

Maybe we just need an rcu_read_lock_held() - does that cover irq being
disabled? I'm not sure what the rules are since the different rcu variants
got merged. Anyways, the right thing to do would be asserting and
documenting that the section is RCU protected.

As for llist not having rcu iterators. The llists aren't RCU protected or
assigned. What's RCU protected is the lifetime of the elements. That said,
we'd need an rmb after fetching llist_head to guarantee that the flusher
sees all the updates which took place before the node got added to the
llist, right?

Can you also add an explanation on how the pending llist is synchronized
against blkg destructions?

Thanks.

-- 
tejun
