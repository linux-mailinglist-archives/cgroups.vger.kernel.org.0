Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1D5AF2BB
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiIFRbf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 13:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiIFRax (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 13:30:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31675B788
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 10:25:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v5so11954646plo.9
        for <cgroups@vger.kernel.org>; Tue, 06 Sep 2022 10:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date;
        bh=zWAJTTb4Ht+/f+u5PAb/NzBa3bogC53Qfzs/V7CfjcI=;
        b=LmO3p85rWzLbzcMnWUQIBLbyWng/AirZyu2ifyuGAiZqbua5cbbBQDvXkJ+A64GmI2
         yD1jU/IhJjT5pVfJPzVuqDr8wuxFsxFJnduvCqiZRSjlG2v8wdBeA4xBe93grksxbxg2
         dWzhwzKZHHI0DJ3pjOJbDXQRsAYx9ZU0KuJSe8X+1onNp+X2226cPiYRNAX49wY/f5MX
         lZSrIE/u+1N5XBDn2qF6ydjGeiz0dMyrPpI1qGDd06BbfO7Zbry9KJfBiYzu0I6QnMkM
         OIN1VqJT3OLEc+vamDl8qG4bvzDOC1zGa0rfoYoSGxVc1DpMiMmVSccGeey4fmO/thyk
         CTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zWAJTTb4Ht+/f+u5PAb/NzBa3bogC53Qfzs/V7CfjcI=;
        b=sdNVnfWQ5araJhaRroIFCETZthUxuLB0ZCG4euINh17gBz575jC8X3Fnud7Hv6hwUL
         QiDcCuQJ9rpD30bIb5Bc/wiLjys0eubVE/zRx04TG8usgH9rVN9lzx2lb0Xjyoq9zH/O
         R0Py4hhGDC+iuV5joP/PyMnuUuwFjSCclyn/x0q/iOyVbuYsdiXEolZWP0PxqAJGbR4f
         569bcqet5iolS0DmDFUNrD5gnbGJAlhL3RYQUpKq8LcHkXEgJlGpEHt5OtfaTfply/B6
         /K6RFU6CvlB1zcWl8/ubtIxAgHdby88fwbAd9Vx5TfkyKWOKN30Ab4VU56N/JTr+LE/Z
         szvQ==
X-Gm-Message-State: ACgBeo2wCBBNlcXBXKxV/vqTeayg9vExg8SATkoqISRN0qqArWooAcdj
        IhrVoVuJTvWmHrx6R6/qpsI=
X-Google-Smtp-Source: AA6agR7KoxwHDA4ZDlxvLpmL6ExhudJeaRrD8NYYv8+CmaZHHwdh9wehZIjoOSBrnKEJAZ9Sp5vd+g==
X-Received: by 2002:a17:902:cf0b:b0:172:72df:4bc with SMTP id i11-20020a170902cf0b00b0017272df04bcmr54345768plg.44.1662485109926;
        Tue, 06 Sep 2022 10:25:09 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e8-20020a630f08000000b0042c012adf30sm8795869pgl.2.2022.09.06.10.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:25:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Sep 2022 07:25:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2 cgroup/for-6.1] cgroup: Improve cftype add/rm error
 handling
Message-ID: <YxeCdHfk2nOUISDw@slm.duckdns.org>
References: <YxUUISLVLEIRBwEY@slm.duckdns.org>
 <20220905131435.GA1765@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905131435.GA1765@blackbody.suse.cz>
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

On Mon, Sep 05, 2022 at 03:14:35PM +0200, Michal Koutný wrote:
> IIUC, the flag is equal to (cft->ss || cft->kf_ops), particularly the
> information is carried in cfs->kf_ops too.

->ss will be NULL for core files even after added. ->kf_ops can be used
instead of the flag.

> Is the effect of cgroup_init_cftypes proper setup of cft->kf_ops?
> I.e. isn't it simpler to just check that field (without the new flag)?
> 
> (No objection to current form, just asking whether I understand the
> impact.)

I prefer having it as a separate flag because it's explicit and can be
tested together with other flags. It's a weak preference tho and I can go
either way if it bothers you much.

Thanks.

-- 
tejun
