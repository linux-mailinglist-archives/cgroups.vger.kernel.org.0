Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0386A67F282
	for <lists+cgroups@lfdr.de>; Sat, 28 Jan 2023 00:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjA0X4n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 18:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjA0X4m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 18:56:42 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD124C9F;
        Fri, 27 Jan 2023 15:56:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k13so6594126plg.0;
        Fri, 27 Jan 2023 15:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBcMmlP1oNR6HwzicKU5lpUtRWz5wSpADFnTmuSK9G4=;
        b=JekLdnK+ZQwksZmuaCiVS64kjOmWLje3UCcDBdnV9poXYxxuO+wkHGWpYnTJq7cAmU
         7XZRUIICytVduVw1l40UPjKGwrrFde3ClLvR8MDo3QI5/Uoj7X9ZwY463+xFMh0nHsX/
         45Nz5HNkjA8BwSVUuxl9NY+ibbh873bLevbT9A718Ou6dQG5pFX/6qQtefVbYHWfRLZb
         EvP/H4NLJczStEuCukbH77eRYHjNXSDJS8yZszY8A6Q9gXy5FpZbxK7Zki4AVpeh+75F
         2sWpeMNcxaN5AKttnaU2bkB/rDn+b00yFHKCerXGzrCvrTYWazvQe+CqZH1j8V08HyxS
         Iq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBcMmlP1oNR6HwzicKU5lpUtRWz5wSpADFnTmuSK9G4=;
        b=k5VlO0rY2ks6oN87tt5RW9z/eEQS2z+JhpJ0JsW/wSH8p+8qtIMS2r+KJdZVujTctb
         ZeRFBh/c1nDRn3EMf3IawHs0FlsxLAhSrYO5tt174ugPdCvP9e4VQiuXqKMqGZH8aalS
         Y2QkgikzlEkI5o3IDxgHy0eB/OyYC7H1UmFosYOPYQxGDRzQb4vj9v44SFASC66feeuy
         001aXKa5Yldvtz3r2sQHBjbYtcR7P/oWPj9W8MmlWfmB3v7RYuCqRCqz/uYk7JXi16IM
         axC+XhXkbyxiv+XEBhc8socy7+MCIrT+iX+1NYdTpxhVrpYhyvO6MOLeTvOIfyECQzQ2
         Eptw==
X-Gm-Message-State: AO0yUKV/c1K2mJwgAp+L6ptMiiDQNVkNUyp9DNz/RSK5LasdAz0dSCWm
        JgwwtE2/by9ZEAHTWBbfygI=
X-Google-Smtp-Source: AK7set+e5UtDRvuLI3S8notjW7Si4+KoIkMPDzLf8KWTOdJSkNLrRou4YX5oBWsvVSF4Vy36F0lGyQ==
X-Received: by 2002:a17:902:e5c1:b0:196:2d55:5b93 with SMTP id u1-20020a170902e5c100b001962d555b93mr12888767plf.20.1674863799806;
        Fri, 27 Jan 2023 15:56:39 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b00189743ed3b6sm3418731plb.64.2023.01.27.15.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 15:56:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Jan 2023 13:56:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 08/15] blk-wbt: open code wbt_queue_depth_changed in
 wbt_update_limits
Message-ID: <Y9RkttC/XAScKdQp@slm.duckdns.org>
References: <20230124065716.152286-1-hch@lst.de>
 <20230124065716.152286-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124065716.152286-9-hch@lst.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 24, 2023 at 07:57:08AM +0100, Christoph Hellwig wrote:
> No real need to all the method here, so open code to it to prepare

I might be being slow but can't understand what the first sentence is
saying. I think making the descriptions a bit more detailed would be
generally helpful.

Thanks.

-- 
tejun
