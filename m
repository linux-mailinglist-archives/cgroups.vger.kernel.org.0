Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29165DFB2
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 23:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbjADWPL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 17:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjADWPJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 17:15:09 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15591CFDE;
        Wed,  4 Jan 2023 14:15:08 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id h192so18418019pgc.7;
        Wed, 04 Jan 2023 14:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kzAyESGIRnB6ZoSVhFAu0vNg+AUYHAiTR9t3Vdi7JU=;
        b=Sm7k5yc8eAeCWJuIWszMzn0BI6Xk9vvIxlP99m51CZibkPqgb8elOeZc+T9mUlBitS
         edlD7jRkd3DA/q8mxg6/HyqAL/6jk/0lW27/1T85ruIg5A4wDlAmsU/67pdL66/UTQiZ
         rdS4lX+t3IhGQj4dk5LPZgatM3yoEXkAJn7skS9Z0UbJOAzqMARu3xFse8xSZ5BeWNU/
         tcdTOBTQH+yD/AdIA+1zkQjz6Ij/GMzHceHAgWPUtPDhGofk9yVI2IamUUxKEbHS/EI/
         JgV67fFIprq5ljOHqEOcuRnWPic/BbU8T6QuU+E0pgzQr6WZIvCzoUMFbbMxkhCJQBLJ
         bYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kzAyESGIRnB6ZoSVhFAu0vNg+AUYHAiTR9t3Vdi7JU=;
        b=7maWBBdIpJB6Loqt9dJdGJlaY2tpw7pXlmPUtVrADcdO5XriWsgjs71MHPLw6J8gVY
         R+Cc/899PV+a/G4FWgO3SVsBdLOvBXYZiHPT0lQfzvzOXay94TLdPrR7U+v9iKDBwXHy
         0BlcMADMxHCu56biwaPOfow3ZY6Uln2vJN9JnDL95fzpd01Rsw1DneRCFgm6h2R37p4n
         D0geDlxOrn1cMlH4h972vnMjTdXBLz+lqKkNMr7O5QXu7cOdLY9DUvy/4WiZaipYmv/o
         +Hp0wlHMiIfob4GtNfHlo+1VTGhGaM1eWZMp+TG+MqzgyngtnxD3ACSpss/3FawVHRKw
         bTtQ==
X-Gm-Message-State: AFqh2koerQuHrqzKogjQZ4cKbZmVNvXkTa7FcpnSekOhFOEE2NSDl3Ji
        2KMx5j+ZuP6aaDwR3E0+A6ZGAHrxebc=
X-Google-Smtp-Source: AMrXdXuDfDknXDpgtszrfF8LHudkp37yQtPEIcZD1Nl4F+p7LnXHv2X0D+QpRx+c6OQ8oZm6rVXB9w==
X-Received: by 2002:aa7:9210:0:b0:577:8bae:29a7 with SMTP id 16-20020aa79210000000b005778bae29a7mr47870372pfo.33.1672870508235;
        Wed, 04 Jan 2023 14:15:08 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c6-20020a624e06000000b00580ff8ff1c7sm19418055pfb.144.2023.01.04.14.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:15:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 12:15:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-iocost: don't make all constants unsigned long long
Message-ID: <Y7X6ajqnPrtFAL0C@slm.duckdns.org>
References: <20221220201819.1497577-1-ydroneaud@opteya.com>
 <20221222135855.GC20830@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221222135855.GC20830@blackbody.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 22, 2022 at 02:58:55PM +0100, Michal Koutný wrote:
> On Tue, Dec 20, 2022 at 09:18:19PM +0100, Yann Droneaud <ydroneaud@opteya.com> wrote:
> > +enum {
> >  	/* switch iff the conditions are met for longer than this */
> >  	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
> > +};
> 
> This looks gratuitous.
> 
> What about indivudial #defines with typed literals instead of the "lazy
> splitting"?

enums are so much better for debugging and tracing. This is a gcc caused
problem where there's no other way to generate the same code between two gcc
versions without splitting the enum definitions. I'm kinda baffled that this
is what they chose to do but can't think of a better way to work around it.

Thanks.

-- 
tejun
