Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF4D7A526D
	for <lists+cgroups@lfdr.de>; Mon, 18 Sep 2023 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjIRS6A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Sep 2023 14:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjIRS57 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Sep 2023 14:57:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED6B10D;
        Mon, 18 Sep 2023 11:57:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c44c0f9138so19316245ad.2;
        Mon, 18 Sep 2023 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695063471; x=1695668271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQDoCkknityzKxYLZnoGn22QkefMP1I66BO9eL96RWg=;
        b=DX44+TkfJEkrRIvfFqd9Zdwn5DZ8gInosV7cROO0uElsTlCV89+H7JT4Pbul457jZT
         EMXQysi1yJjdUQeFd644wJUDCohAlNJ1mT0lxoQhiJwvxjJeQDcJgplo3PBJTSA1iI9G
         3btEyg8x2EsG9AeJ3jphxKuhPtZlRETAj00qOpiT1TC8lFrytHT7ObcJgEPf4PSp8XJ9
         CzgE6tVmncuHlDpcon+jLI7id6Ld14Pyi5R+WO6bqlWNVpBo9Tu0IBMNyr5AD5G8DBbU
         qvPCEbi3bmusYMJ/ceFgnSd07mJmmTfkFkUlr6tBLcafMNb1zJbPSYwuil24+HzjQHzw
         Bv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063471; x=1695668271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQDoCkknityzKxYLZnoGn22QkefMP1I66BO9eL96RWg=;
        b=nAdHaOT6mSdUlcEFTldTupz8V4R80fS+vVHrOmizdx+CD7x6K9YDg4Basay8NFmJPy
         EZT4U4HDaO/w/B71HGSmU5BbEey8vLLFqfaRsVqpJstf0/k5UlZxts/R6KasiL8iZOFw
         5XPSc1EDNhp//WB+DW6dE1xIvAUHXGiGiYThSF5d2R+1MiheiPC5Wr+qXQURW0fDKMu0
         I43QxLvHar6dydNoAGnMlVWEh1bnGV1N7U1ji5LY0CNnbE8GHxKaWPYLtJA6Na4Y4lix
         ftWj8MGKEMm4XMMhiG7HguvMNsN1z+kbZDg9djFOvAWjKo+JiGYI0LBwz2ipCsyHefyR
         XaKw==
X-Gm-Message-State: AOJu0YwbAgWm+l1dZUn9Ax9TNKmrPRfSGVET6jgc/L4EDGgyKkv9TkiW
        DRHzXwvDYBnEEZxZbbdyekc=
X-Google-Smtp-Source: AGHT+IFXSRZjXV7Qeq0rPe1QSZNvckH3pxdhiyDsqIGPtj0hDRufrXVyv4PtUXuAU/0CElPFMDJUKg==
X-Received: by 2002:a17:902:c404:b0:1c3:1f0c:fb82 with SMTP id k4-20020a170902c40400b001c31f0cfb82mr8807898plk.41.1695063471578;
        Mon, 18 Sep 2023 11:57:51 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902bd9500b001c1f016015esm8597114pls.84.2023.09.18.11.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:57:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Sep 2023 08:57:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: Check for ret during cgroup1_base_files cft
 addition
Message-ID: <ZQidrVijM8g6tdBC@slm.duckdns.org>
References: <96694dfc5f4caf4d84a740c3b18b0a456c9ff522.1694501024.git.kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96694dfc5f4caf4d84a740c3b18b0a456c9ff522.1694501024.git.kamalesh.babulal@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 12, 2023 at 12:34:34PM +0530, Kamalesh Babulal wrote:
> There is no check for possible failure while populating
> cgroup1_base_files cft in css_populate_dir(), like its cgroup v2 counter
> parts cgroup_{base,psi}_files.  In case of failure, the cgroup might not
> be set up right.  Add ret value check to return on failure.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Applied to cgroup/for-6.7 with double spaces removed.

Thanks.

-- 
tejun
