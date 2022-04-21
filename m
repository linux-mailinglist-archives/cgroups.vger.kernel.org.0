Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8488C50AAF3
	for <lists+cgroups@lfdr.de>; Thu, 21 Apr 2022 23:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiDUVsI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442227AbiDUVrj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 17:47:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177534EF40;
        Thu, 21 Apr 2022 14:44:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n18so6624335plg.5;
        Thu, 21 Apr 2022 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GIkmPRn6aXIFTLXMDEzU8Z7cPf9kdXdPCyaOczwE6x0=;
        b=Y+ot/N7E3NqtwNRkxxSQvG8RLexpxttLfKY4X2H753dGZgDytqswn3fJSKyb3cJFbH
         li+mL9j7bJx2hlPee+M4Olu2UZNUV2GxkQAjVde+z8e/75fQjDwi9Fnvqbrk3yHU/RBZ
         9NE7UFSIwy6xkhNy7ODaqcifxQ58kzt+nyKjzpBJ2xVhIXHf8KY3VVOt4PiYl+cSzeKY
         Nu0bQZioVPXHgcvVihXVQDPHhnx9ZdX1+d0UPvh5V2OMKUv0qIIc9T9OoQcyq78QovKw
         z43U2HpqbNvSPKATYbDIhMdIrOfXUdMI4W5mQynu/1WEcGaLs4vVOgTTz5l8xUcx1a32
         Vrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GIkmPRn6aXIFTLXMDEzU8Z7cPf9kdXdPCyaOczwE6x0=;
        b=YFr5kLgxlfMNMzxH2jjcYIHi2Qxja5do0JWMKn4RHTm5Ld93s3uh1ZmrykQ3xqKJCL
         M7cgkwacL+xKMe5gesjU0sl59kxVBpjU89S4nYSBJvumgYs9+QbE/Ayxgd2dFY29X3Yr
         MDKFlCFoDVKo/WGsujEPzqC+YeFKAb0Kb2oEYh3lz9haiqzkrHlw4JXRjQa3q+VovQK3
         AfP6afhykiuERVVbzd+Npq2vi8xO2IPIQBAJzbWaaauNQGsBKi2Uirwv3ive3G1jxIYO
         Bpw0i6LCmhnEnq7/av/KoZ4UcTpuG2f+MUtn0sJOnjk3EkXfOr/igHPsZTTKRUfLMez5
         qBFA==
X-Gm-Message-State: AOAM531OiWjrDJlwFAEz9SXkCAf6kKILXIvcw7PirtrK9+T/LzPsUxAD
        VInJFdmcnD02+QYJaDQmT7M=
X-Google-Smtp-Source: ABdhPJxHcJDy80tcA6sx3LqqnfHByJ4eX9ilg9ZOtqESXPl+xJmI1z5M+822VXfcwS0QGTJePQ/7fw==
X-Received: by 2002:a17:90a:6445:b0:1d6:a69e:406c with SMTP id y5-20020a17090a644500b001d6a69e406cmr4662624pjm.49.1650577485382;
        Thu, 21 Apr 2022 14:44:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:15fa])
        by smtp.gmail.com with ESMTPSA id y4-20020a056a00190400b004fac0896e35sm80878pfi.42.2022.04.21.14.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:44:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 21 Apr 2022 11:44:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: Re: make the blkcg and blkcg structures private
Message-ID: <YmHQS1pyIglK+gfS@slm.duckdns.org>
References: <20220420042723.1010598-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Apr 20, 2022 at 06:27:08AM +0200, Christoph Hellwig wrote:
> this series cleans up various lose end in the blk-cgroup code to make it
> easier to follow in preparation of reworking the blkcg assignment for
> bios.  The biggest change is that most of <linux/blk-cgroup.h> is now
> taken private into block/.

The patches look all good to me and I'm not against making things more
private but can you elaborate on the rationale a bit more? By and large, we
have never been shy about putting things in the headers if there's *any*
(perceived) gain to be made from doing so, or even just as a way to pick the
locations for different things - type defs go on header and so on. Most of
the inlines and [un]likely's that we have are rather silly with modern
compilers with global optimizations, so it does make sense to get tidier,
but if that's the rationale, mentioning that in the commit message, even
briefly, would be great - ie. it should explain the benefits of adding these
few accessors to keep the definition private.

Thanks.

-- 
tejun
