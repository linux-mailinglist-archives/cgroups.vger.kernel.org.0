Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3891E28AA
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2020 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389490AbgEZRYw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 May 2020 13:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388844AbgEZRXo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 May 2020 13:23:44 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF73C03E96D;
        Tue, 26 May 2020 10:23:43 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dh1so9783207qvb.13;
        Tue, 26 May 2020 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SYQZMFTEBJ18xeJeS1buRtQuG/fExe+cZBQxRWLCEdI=;
        b=DBB2dXXyQS8i2KL6fgI0iY3v+kzmXamXskvxCjgHOeueAxTFhY4qC9ElWV+f2i479K
         QgcXP98W5NFfdi6cLmwRIm5jRaajZ8Xq7c0jS72HCWME/8Aas5rcXPl/uwSEOB+PWYmO
         Z3J++foQU1ozkoo2brpOSl+duSw8dye0KsWj/pmWQjzzjVRDRm7PUb6cnoCrFBZvZwMW
         InpmBDBrFiYlJd+AhV8vkCA3HCv+Ri0pjM+wDegKgRiYKUdb2EOcEM6peCwi5NR1/peF
         tGUKznRKDoHnuAvvD+pPYLR7nxGJWvxFBE7FlmmQc/4cwA0CRXHJEEDCXEqIH6PsKNep
         vYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SYQZMFTEBJ18xeJeS1buRtQuG/fExe+cZBQxRWLCEdI=;
        b=n7+QUx2OtX1zV0w2oYk0t7Pef67ElN6QPRgQKAHQOc9kLv8K7Ozbqa8zM9UuucCvEv
         WY+3Gj0lpo1uLHr+4saZL53Y5Ebj6Z0GJTTFf1Rhm7Wzx3oO3Qx1BBo//GOouIcW+A8u
         O50yZorojILT/RlDB8I4MfeTDnubo6r5qO/LRBlUHDUhXwEV/XcolkzVcdAbMarB1D5s
         7M7pqdU2HNNKGN7OhWFXGJhYeYe4bsq+MYn57/yRco3IKTRwxCqbzRrEuVlCZR6CJQQi
         VnXZVWzJFMTMsSioeZeU5YubTi/seKIW9yst7FFeP3CrAuEwXk0MEcDhkn5hOuyr0dHn
         IrpQ==
X-Gm-Message-State: AOAM532doG7CK3oRbmPA1EDfzOkVsbLyBSx4qu1NptfTr7Ld7E+b586t
        oCdmE8sKOqqQd/v7g0l0XUc=
X-Google-Smtp-Source: ABdhPJxNcrcKF+fqaOMGL5W+NexLSdpNhiaupcVndx+6tqKzg2Z+N1bEowXKJaoJNYdwASCyIlLg3w==
X-Received: by 2002:ad4:4d03:: with SMTP id l3mr21657230qvl.158.1590513823004;
        Tue, 26 May 2020 10:23:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:85c0])
        by smtp.gmail.com with ESMTPSA id d56sm277843qtb.54.2020.05.26.10.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 10:23:42 -0700 (PDT)
Date:   Tue, 26 May 2020 13:23:40 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Wu Bo <wubo40@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, Markus.Elfring@web.de,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] blkcg:Fix memory leaks in blkg_conf_prep()
Message-ID: <20200526172340.GD83516@mtj.thefacebook.com>
References: <1589805366-328489-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589805366-328489-1-git-send-email-wubo40@huawei.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 18, 2020 at 08:36:06PM +0800, Wu Bo wrote:
> From: Wu Bo <wubo40@huawei.com>
> 
> If a call of the function blkg_lookup_check() failed,
> we should be release the previously allocated block group 
> before jumping to the lable 'fail_unlock' in the implementation of 
> the function blkg_conf_prep().
> 
> Suggested-by: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Wu Bo <wubo40@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
