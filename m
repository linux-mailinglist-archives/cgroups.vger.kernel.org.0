Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE053BFFA
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 22:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbiFBUjk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 16:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239284AbiFBUj3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 16:39:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4BE1FCDE;
        Thu,  2 Jun 2022 13:39:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gd1so5906222pjb.2;
        Thu, 02 Jun 2022 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NYkACjksTq7D5aqYKY+rKmNd5ashkIfCvgLNEkSUbY4=;
        b=VOoyvWVAcqaU05NT1mJw6gqT2XZyQl9VZosdCL3rWV7Sfb31CIedlhghvwKlyCTlgM
         4EmYtZsp0oDGXH7Sfq9OUYqx6T57oS/fqxkS6XU+BF9VG8iMEagWxwaCBeV59dwks9Ne
         +sxGEJ/V+morFEZXMOgoH98Qnf5I3+3Konysn2VkKRxS8dwpQN7ZIORUzMQmYcIcn/mO
         fHc7VZN2++Hb/wqYaHVxLILDutZdZurupx6x2KAVR1NzmA/9ttj5Ao0OePBo66dbNrpW
         B6sbZXTu632SvtkE+Y9GLIw2dJcS8mZ9L9eOGSedtmCMHTljAxs32Md+vZk2pkQZlFLS
         S/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NYkACjksTq7D5aqYKY+rKmNd5ashkIfCvgLNEkSUbY4=;
        b=ixSNDwue02pvkZnfE4blIZO4XGIuqwDeOVkZA9ps8bpIRXpE4muzipdHKLZw0334M1
         J8iNiJ+UTptJbju//R0aWg13a0z7hwTAb+nRQHmNK7xVlXxUItwyu8nUG57/ps3jqH19
         n06LjiInXPw62x+3KocmSo8uUnsZ7Kk8T/yUDeDXzOtF2v7zTfqAUdKxKOdB3JD3gayo
         0kA4Zl34enNBzvYmQhDHm50MrzFHGpmlcW+AJ+qg/g3hmtj905m9c3kq9ca56budd+aI
         201UOn3hUkrTQzeNWRx6BFoh6YA/Qe4I3K3ybHPQYQvuD1gW6LQINdCIkBx/6QHKdGVT
         9g9Q==
X-Gm-Message-State: AOAM532X6PSxvUv5jigD5EtC4zmLTzmO/q4xsH+2glv67oG9Y8c0J2BZ
        QdJO04yXUceMP3ZifvmwRwk=
X-Google-Smtp-Source: ABdhPJwCauiVmlbZVrmjHvh14oNg3atOmWAenuo+u7mo7KfDoP3F/8vvEv+MM5EaVGAijl7adpq+6g==
X-Received: by 2002:a17:90a:9505:b0:1df:2162:2bb5 with SMTP id t5-20020a17090a950500b001df21622bb5mr42153874pjo.73.1654202358802;
        Thu, 02 Jun 2022 13:39:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:49ff])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b0016403cae7desm3209918plb.276.2022.06.02.13.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 13:39:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Jun 2022 10:39:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v6 2/3] blk-cgroup: Return -ENOMEM directly in
 blkcg_css_alloc() error path
Message-ID: <Ypkf9N0sIZdzizL1@slm.duckdns.org>
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602192020.166940-3-longman@redhat.com>
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

On Thu, Jun 02, 2022 at 03:20:19PM -0400, Waiman Long wrote:
> For blkcg_css_alloc(), the only error that will be returned is -ENOMEM.
> Simplify error handling code by returning this error directly instead
> of setting an intermediate "ret" variable.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
