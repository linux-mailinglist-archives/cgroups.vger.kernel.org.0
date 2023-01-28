Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CE67F2D1
	for <lists+cgroups@lfdr.de>; Sat, 28 Jan 2023 01:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjA1ANq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 19:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjA1ANp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 19:13:45 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8527B40C;
        Fri, 27 Jan 2023 16:13:44 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 141so4267552pgc.0;
        Fri, 27 Jan 2023 16:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcu669nM+z2o5SFfsE7BkghAL02DbLfGfHTyhhM1+68=;
        b=UnSYqcDXBwiBNro4ZJ4iBT3fSVSziSa55q4eR7nZ4PL2nI9z58HOVgKY3LJB+AR4WV
         6CAhe3NzY5T8adzJiG8+J5uOXmPQu/jjEGm9BkTvHS2j3bMfHpiHGU76dn66tnNrR/j0
         +TNE/F/DsZlrWiMpa/1sxq4qRZ/YK9XEpiJrm0LMzp6Od6SjAiwbWeftU3Jwnekb3I8g
         jkCYH5FKw0mciGg4ntsuqv41388uSnQCJRkuIPDgDI4/5qdeDFAbxHjRP2LbHFjNPkeF
         dUrR3mN9SzSgEqL9T7xX/llBpmI1k5sPMpIh+btvrIcfabEaAjTYKPcfy6Ijsee1EF3z
         y9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcu669nM+z2o5SFfsE7BkghAL02DbLfGfHTyhhM1+68=;
        b=r9ya5viGzfv/TtHrwzf7U2NcYlj92vpyZHmCLH0Lhkw4nxgffIvUSzjiq6+Jy5ruNG
         9d28vSz8u4SD6EcdEmxsz7G8XI+Ou5DI8w6XYvEYiMLqwIWEiFnrEOReCc2tV2qR8ia2
         s8PgkSBezOJQmT1pzXYmKmJ4lYXLlKMI5QpGtVwpRQUqdIdZrgFNBdf19lX+b6QF7/XA
         izH3nr5eA0waLl/vmVYEUNbS3n8WiJ5IXgu/ux08l04ak8z6yqeOCKuOsN3ABPf4dOZT
         dpC6x3YKj1A9HM89KtVX1qpff2ZTt1TEp9kMMeZgwUNnjrQowvbdeX7IQOB0b2MIQjsC
         eqEg==
X-Gm-Message-State: AO0yUKVKrYH70+wXw5mmCnMcaNdNJRsxHqToG15faB7TnlSvi6RLJrzX
        zD079ZXkvEyJ0nlM/14e39Q=
X-Google-Smtp-Source: AK7set8P0HeeyPbNFWNlQH2RzwsqES932ZejjnjvD0m4I8H2HR0ziBAoQd04u4bTM7C11eV8fIGbqw==
X-Received: by 2002:aa7:8e01:0:b0:593:9265:3963 with SMTP id c1-20020aa78e01000000b0059392653963mr687332pfr.31.1674864824258;
        Fri, 27 Jan 2023 16:13:44 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j11-20020aa7928b000000b0058bb8943c9asm3132381pfa.161.2023.01.27.16.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:13:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Jan 2023 14:13:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 15/15] blk-cgroup: move the cgroup information to struct
 gendisk
Message-ID: <Y9RotmRIyv+2IEj9@slm.duckdns.org>
References: <20230124065716.152286-1-hch@lst.de>
 <20230124065716.152286-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124065716.152286-16-hch@lst.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 24, 2023 at 07:57:15AM +0100, Christoph Hellwig wrote:
> cgroup information only makes sense on a live gendisk that allows
> file system I/O (which includes the raw block device).  So move over
> the cgroup related members.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

The series looks fine to me other than the nits.

Thanks.

-- 
tejun
